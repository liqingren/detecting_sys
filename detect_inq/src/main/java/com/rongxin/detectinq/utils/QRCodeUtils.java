package com.rongxin.detectinq.utils;
import com.google.zxing.*;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.geom.RoundRectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Hashtable;

/**
 * 二维码生成工具类
 */
public class QRCodeUtils {
    private static final String CHARSET = "utf-8";
    public static final String FORMAT = "JPG";
    // 二维码尺寸
    private static final int QRCODE_SIZE = 300;


    /**
     * 生成二维码
     *
     * @param content      二维码内容
     * @return 图片
     * @throws Exception
     */
    public static BufferedImage createImage(String content) throws Exception {
        Hashtable<EncodeHintType, Object> hints = new Hashtable<EncodeHintType, Object>();
        hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
        hints.put(EncodeHintType.CHARACTER_SET, CHARSET);
        hints.put(EncodeHintType.MARGIN, 1);
        BitMatrix bitMatrix = new MultiFormatWriter().encode(content, BarcodeFormat.QR_CODE, QRCODE_SIZE, QRCODE_SIZE,
                hints);
        int width = bitMatrix.getWidth();
        int height = bitMatrix.getHeight();
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
                image.setRGB(x, y, bitMatrix.get(x, y) ? 0xFF215E21 : 0xFFFFFFFF);
            }
        }
        return image;
    }

    /**
     * 生成二维码（指定路径保存）
     *
     * @param content 内容
     * @throws Exception
     */
    public static String encode(String content) throws Exception {
        BufferedImage image = createImage(content);
        //获取当前项目路径
        File file = new File("");
        String filePath = file.getCanonicalPath();
        System.out.println(filePath);
        //将生成的二维码放在/src/webapp/img/的文件夹下
        String path=filePath+"\\detecting_page\\src\\main\\webapp\\image\\"+content+".jpg";
        mkdirs(path);
        ImageIO.write(image, FORMAT, new File(path));
        String codePath=content+".jpg";
        return codePath;
    }

//    /**
//     * 生成二维码(直接将二维码以图片输出流返回）
//     *
//     * @param content 内容
//     * @return
//     * @throws Exception
//     */
//    public static BufferedImage encode(String content) throws Exception {
//        BufferedImage image = createImage(content);
//        return image;
//    }

    public static void mkdirs(String destPath) {
        File file = new File(destPath);
        // 当文件夹不存在时，mkdirs会自动创建多层目录，区别于mkdir．(mkdir如果父目录不存在则会抛出异常)
        if (!file.exists() && !file.isDirectory()) {
            file.mkdirs();
        }
    }



    /**
     * 解析二维码
     *
     * @param file 二维码图片
     * @return
     * @throws Exception
     */
    public static String decode(File file) throws Exception {
        BufferedImage image;
        image = ImageIO.read(file);
        if (image == null) {
            return null;
        }
        BufferedImageLuminanceSource source = new BufferedImageLuminanceSource(image);
        BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));
        Result result;
        Hashtable<DecodeHintType, Object> hints = new Hashtable<DecodeHintType, Object>();
        hints.put(DecodeHintType.CHARACTER_SET, CHARSET);
        result = new MultiFormatReader().decode(bitmap, hints);
        String resultStr = result.getText();
        return resultStr;
    }

//    /**
//     * 解析二维码
//     *
//     * @param path 二维码图片地址
//     * @return
//     * @throws Exception
//     */
//    public static String decode(String path) throws Exception {
//        return decode(new File(path));
//    }


}
