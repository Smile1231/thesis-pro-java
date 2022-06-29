package com.jinmao.thesisproject.utils;

/**
 * @author jinmao
 * @create 2022-05-20-13:51
 * @Description B -> KB -> MB -> GB
 */
public class ConversionUtil {

    public static Long byte2MB(long size){
        return  size / 1024 / 1024;
    }
}
