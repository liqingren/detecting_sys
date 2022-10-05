package com.rongxin.detectinq.controller;

import com.rongxin.common.R;
import com.rongxin.detectinq.entity.Users;
import com.rongxin.detectinq.entity.vo.MoResult;
import com.rongxin.detectinq.entity.vo.MoUser;
import com.rongxin.detectinq.utils.QRCodeUtils;
import com.rongxin.detectinq.utils.finalClass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationOperation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.aggregation.LookupOperation;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin
@RequestMapping("/detectinq/mouser")
public class MoUserController {
    @Autowired
    MongoTemplate mongoTemplate;

//    @RequestMapping("/test1")
//    public void test1() {
//        LookupOperation lookupOperation = LookupOperation.newLookup().from("result")
//                .localField("userId").foreignField("userId").as("results");
//        Criteria criteria = Criteria.where("userId").is(2).and("resultstate").not().size(0);
//        AggregationOperation match = Aggregation.match(criteria);
//        Aggregation aggregation = Aggregation.newAggregation(lookupOperation, match);
////        Aggregation aggregation = Aggregation.newAggregation(lookupOperation);
//        List<Map> list = mongoTemplate.aggregate(aggregation, "user", Map.class).getMappedResults();
//        for (Map map : list) {
//            System.out.println(map.get("userId") + "\t" + map.get("results"));
//
//        }
//    }
//
//
//    @RequestMapping("/getresultbypage")
//    public R getResultByPage(@RequestParam(value = "pageNum",required = false,defaultValue = "1") Integer pageNum,
//                             @RequestParam(value="pageSize",required = false,defaultValue = "10") Integer pageSize,
//                             @RequestParam("id") Integer id){
//        Query query = new Query(Criteria.where("resultstate").exists(true).and("userId").is(id));
//        long count = mongoTemplate.count(query, MoResult.class);//总记录数
//        List<MoResult> list = mongoTemplate.find(query.skip(pageNum).limit(pageSize), MoResult.class);
//        return R.ok().data("result",list);
//    }


    /**
     * 获取健康码
     * @param id
     * @return
     */
    @RequestMapping("/getcode")
    public R getCode(@RequestParam("id") Integer id) {
        //根据userid获取用户信息
        Query query1 = new Query(Criteria.where("userId").is(id));
        MoUser moUser = mongoTemplate.findOne(query1, MoUser.class);
        //日期转换
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if(moUser!=null) {
            //获取用户最近一次核酸结果
            Query query2 = new Query(Criteria.where("resultstate").exists(true).and("userId").is(id));
            query2.with(Sort.by(Sort.Order.desc("resultTime")));
            MoResult result = mongoTemplate.findOne(query2.limit(1), MoResult.class);
            //判断核酸是否为阳性
            if (result.getResultstate().equals(finalClass.RESULT_ERROR)) {
                //如果最近一次核酸结果是阳性，健康码状态变为2，健康码变红
                if(moUser.getState()!=finalClass.STATE_RED) {
                    moUser.setState(finalClass.STATE_RED);
                    //最后修改时间
                    Date date = new Date();
                    String updatedTime = sdf.format(date);
                    moUser.setUpdateTime(updatedTime);
                    mongoTemplate.save(moUser);
                }
            } else if (result.getResultstate().equals(finalClass.RESULT_OK)) {
                //获取最近一次核酸的检测时间(单位毫秒)
                long resultTime = 0;
                try {
                    Date date = sdf.parse(result.getResultTime());
                    resultTime = date.getTime();
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                //获取当前时间(单位毫秒)
                long nowTime = System.currentTimeMillis();
                //计算两者时间差
                long timeDiff = (nowTime - resultTime) % (1000 * 60 * 60 * 24) / (1000 * 60 * 60) + (nowTime - resultTime) / (1000 * 60 * 60 * 24) * 24;
                if (timeDiff < finalClass.DATE_YELLOW) {
                    //如果小于48小时没做核酸，健康码状态变为0，健康码变绿
                    if(moUser.getState()!=finalClass.STATE_GREEN) {
                        moUser.setState(finalClass.STATE_GREEN);
                        //最后修改时间
                        Date date = new Date();
                        String updatedTime = sdf.format(date);
                        moUser.setUpdateTime(updatedTime);
                        mongoTemplate.save(moUser);
                    }
                } else if (timeDiff > finalClass.DATE_YELLOW && timeDiff < finalClass.DATE_RED) {
                    //如果48~72小时没做核酸，健康码状态变为1，健康码变黄
                    if(moUser.getState()!=finalClass.STATE_YELLOW) {
                        moUser.setState(finalClass.STATE_YELLOW);
                        //最后修改时间
                        Date date = new Date();
                        String updatedTime = sdf.format(date);
                        moUser.setUpdateTime(updatedTime);
                        mongoTemplate.save(moUser);
                    }
                } else if (timeDiff > finalClass.DATE_RED) {
                    //如果72小时以上没做核酸，健康码状态变为2，健康码变红
                    if(moUser.getState()!=finalClass.STATE_RED) {
                        moUser.setState(finalClass.STATE_RED);
                        //最后修改时间
                        Date date = new Date();
                        String updatedTime = sdf.format(date);
                        moUser.setUpdateTime(updatedTime);
                        mongoTemplate.save(moUser);
                    }
                }
            }
            try {
                //如果状态为0，健康码是绿色，状态为1，健康码变黄，状态为2，健康码变红
                if (moUser.getState() == finalClass.STATE_GREEN) {
                    //生成绿色二维码
                    Integer color = 0xFF215E21;
                    //将健康码存入文件
                    QRCodeUtils.encode(moUser.getCard(), color);
                } else if (moUser.getState() == finalClass.STATE_YELLOW) {
                    //生成黄色二维码
                    Integer color = 0xFFFFFF00;
                    //将健康码存入文件
                    QRCodeUtils.encode(moUser.getCard(), color);
                } else if (moUser.getState() == finalClass.STATE_RED) {
                    //生成红色二维码
                    Integer color = 0xFFFF0000;
                    //将健康码存入文件
                    QRCodeUtils.encode(moUser.getCard(), color);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return R.ok();
        }
        return R.error();
    }

}
