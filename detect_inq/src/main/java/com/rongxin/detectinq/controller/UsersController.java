package com.rongxin.detectinq.controller;


import com.github.pagehelper.PageInfo;
import com.rongxin.common.R;
import com.rongxin.detectinq.config.SpringWebSocketHandler;
import com.rongxin.detectinq.entity.Result;
import com.rongxin.detectinq.entity.Users;
import com.rongxin.detectinq.service.impl.ResultServiceImpl;
import com.rongxin.detectinq.service.impl.UsersServiceImpl;
import com.rongxin.detectinq.utils.QRCodeUtils;
import com.rongxin.detectinq.utils.finalClass;
import com.rongxin.detectlog.log.annotation.IOLogRecorder;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.socket.TextMessage;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ren
 * @since 2022-09-28
 */
@RestController
@CrossOrigin
@RequestMapping("/detectinq/users")
public class UsersController {
    @Autowired
    UsersServiceImpl usersService;
    @Autowired
    ResultServiceImpl resultService;
    @Autowired
    SpringWebSocketHandler springWebSocketHandler;
    @Autowired
    JavaMailSender javaMailSender;

    /**
     * 注册
     * @param user
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/register")
    public R register(@RequestBody Users user){
        //判断身份证号唯一性
        String card = user.getCard();
        Integer count = usersService.getOnlyUser(card);
        if(count>0){
            return R.error();
        }
        Date date = new Date();
        user.setCreateTime(date);
        boolean flag = usersService.save(user);
        if(flag) {
            //根据身份证号查询用户信息
            Users userCard = usersService.getByCard(user.getCard());
            try {
                //生成绿色二维码
                Integer color=0xFF215E21;
                //将健康码存入文件并返回文件名
                String codePath = QRCodeUtils.encode(user.getCard(),color);
                //将健康码文件名存入用户表
                userCard.setCodePath(codePath);
                //最后修改时间
                Date updatedTime = new Date();
                userCard.setUpdateTime(updatedTime);
                usersService.updateById(userCard);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return R.ok();
        }
        return R.error();
    }

    /**
     * 登录
     * @param card
     * @param password
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/login")
    public R login(HttpServletRequest request,@RequestParam("card") String card, @RequestParam("password") String password) {

        System.out.println("登录：" + card + "：" + password);
        HttpSession session = request.getSession();
        if(session != null){
            try{
                session.setAttribute("SESSION_USERNAME", card);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        Users user = new Users();
        if(card!=null&&password!=null){
            user.setCard(card);
            user.setPassword(password);
        }
        //登录
        int count = usersService.login(user);
        if(count>0) {
            //根据身份证号查询用户信息
            Users userCard = usersService.getByCard(card);
            //判断是否是第一次登录
            int reCount = resultService.getCountByUserId(userCard.getId());
            if(reCount!=0){
                //获取用户最近一次核酸结果信息
                Result result = resultService.getResultByUserId(userCard.getId());
                //判断健康码状态
                judgeCodeColor(userCard,result);
                try {
                    //如果状态为0，健康码是绿色，状态为1，健康码变黄，状态为2，健康码变红
                    if(userCard.getState()== finalClass.STATE_GREEN){
                        //生成绿色二维码
                        Integer color = 0xFF215E21;
                        //将健康码存入文件
                        QRCodeUtils.encode(user.getCard(), color);
                    }
                    else if(userCard.getState()== finalClass.STATE_YELLOW) {
                        //生成黄色二维码
                        Integer color = 0xFFFFFF00;
                        //将健康码存入文件
                        QRCodeUtils.encode(user.getCard(), color);
                    }
                    else if(userCard.getState()== finalClass.STATE_RED){
                        //生成红色二维码
                        Integer color = 0xFFFF0000;
                        //将健康码存入文件
                        QRCodeUtils.encode(user.getCard(), color);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            return R.ok().data("user",userCard);
        }
        return R.error();
    }

    /**
     * 判断健康码状态值
     * @param userCard
     * @param result
     */
    public void judgeCodeColor(Users userCard,Result result){
        if(result.getResultstate().equals(finalClass.RESULT_ERROR)){
            //如果最近一次核酸结果是阳性，健康码状态变为2，健康码变红
            if(userCard.getState()!=finalClass.STATE_RED) {
                userCard.setState(finalClass.STATE_RED);
                //最后修改时间
                Date updatedTime = new Date();
                userCard.setUpdateTime(updatedTime);
                usersService.updateById(userCard);
            }
        }else if(result.getResultstate().equals(finalClass.RESULT_OK)) {
            //获取最近一次核酸的检测时间(单位毫秒)
            long resultTime = result.getResultTime().getTime();
            //获取当前时间(单位毫秒)
            long nowTime = System.currentTimeMillis();
            //计算两者时间差
            long timeDiff = (nowTime - resultTime) % (1000 * 60 * 60 * 24) / (1000 * 60 * 60) + (nowTime - resultTime) / (1000 * 60 * 60 * 24) * 24;
            if (timeDiff < finalClass.DATE_YELLOW) {
                //如果小于48小时没做核酸，健康码状态变为0，健康码变绿
                if (userCard.getState() != finalClass.STATE_GREEN) {
                    userCard.setState(finalClass.STATE_GREEN);
                    //最后修改时间
                    Date updatedTime = new Date();
                    userCard.setUpdateTime(updatedTime);
                    usersService.updateById(userCard);
                }
            } else if (timeDiff > finalClass.DATE_YELLOW && timeDiff < finalClass.DATE_RED) {
                //如果48~72小时没做核酸，健康码状态变为1，健康码变黄
                if (userCard.getState() != finalClass.STATE_YELLOW) {
                    userCard.setState(finalClass.STATE_YELLOW);
                    //最后修改时间
                    Date updatedTime = new Date();
                    userCard.setUpdateTime(updatedTime);
                    usersService.updateById(userCard);
                }
            } else if (timeDiff > finalClass.DATE_RED) {
                //如果72小时以上没做核酸，健康码状态变为2，健康码变红
                if (userCard.getState() != finalClass.STATE_RED) {
                    userCard.setState(finalClass.STATE_RED);
                    //最后修改时间
                    Date updatedTime = new Date();
                    userCard.setUpdateTime(updatedTime);
                    usersService.updateById(userCard);
                }
            }
        }

    }



//    /**
//     * 判断身份证号是否唯一
//     * @param card
//     * @return
//     */
//    @IOLogRecorder
//    @RequestMapping("/judge")
//    public R judgeSingleUser(@RequestParam("card") String card){
//        Users user = usersService.getByCard(card);
//        if(user!=null){
//            return R.error();
//        }
//        return R.ok();
//    }
//


    /**
     * 根据身份证号查询用户信息
     * @param code
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/getuser")
    public R getUser(@RequestParam("code") String code){
        Users user = usersService.getByCard(code);
        return R.ok().data("userCard",user);
    }

    /**
     * 查询所有核酸结果
     * @param id
     * @return
     */
    @IOLogRecorder
    @RequestMapping("/getuserresult")
    public R GetUserResult(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
                           @RequestParam(value="pageSize",required = false,defaultValue = "10") Integer pageSize,
                           @RequestParam("id") Integer id,
                           @RequestParam(value="keyword",required = false) String keyword){
        //根据身份证号分页查询核酸结果
        PageInfo<Result> result = resultService.getResultByPage(pageNum,pageSize,id,keyword);
        return R.ok().data("result",result);
    }


    /**
     *
     * 指定发送
     * http://localhost:8001/detectinq/users/websocket/sendToUser
     * @param
     * @param info
     * @return
     */
    @SneakyThrows
    @ResponseBody
    @RequestMapping(value = "/websocket/sendToUser", method = {RequestMethod.POST, RequestMethod.GET})
    public String send(@RequestParam(value = "card") String card, @RequestParam(value = "info") String info) {

        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage,true);
        helper.setSubject("这是一封测试邮件");
        helper.setFrom("2794975447@qq.com");
        helper.setTo("3343087896@qq.com");
        helper.setSentDate(new Date());
        helper.setText(info);
        javaMailSender.send(mimeMessage);

        springWebSocketHandler.sendMessageToUser(card, new TextMessage(info));
        System.out.println("发送至：" + card);
        return "success";
    }


    /**
     * 发送到全部用户
     * http://localhost:8001/detectinq/users/websocket/broadcast
     * @param info
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/websocket/broadcast", method = {RequestMethod.POST, RequestMethod.GET})
    public String broadcast(@RequestParam(value = "info") String info) {
        springWebSocketHandler.sendMessageToUsers(new TextMessage("广播消息：" + info));
        System.out.println("广播成功");
        return "success";
    }




}

