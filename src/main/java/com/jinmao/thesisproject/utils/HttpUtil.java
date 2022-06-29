package com.jinmao.thesisproject.utils;

import org.springframework.http.HttpHeaders;

import java.io.File;
import java.util.Date;

/**
 * @author jinmao
 * @create 2022-05-20-00:39
 * @Description
 */
public class HttpUtil {
    public static HttpHeaders getInputStreamHeader(File file){
        HttpHeaders headers = new HttpHeaders();
        headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
        headers.add("Content-Disposition", String.format("attachment; filename=\"%s\"", file.getName()));
        headers.add("Pragma", "no-cache");
        headers.add("Expires", "0");
        headers.add("Last-Modified", new Date().toString());
        headers.add("ETag", String.valueOf(System.currentTimeMillis()));

        return headers;
    }
}
