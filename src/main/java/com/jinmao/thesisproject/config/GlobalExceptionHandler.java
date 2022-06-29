package com.jinmao.thesisproject.config;

import com.alibaba.fastjson.JSONObject;
import com.jinmao.thesisproject.nums.ResultCodeEnum;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author jinmao
 * @create 2022-05-20-09:55
 * @Description
 */
public class GlobalExceptionHandler {
    @ResponseBody
    @ExceptionHandler(Exception.class)
    public Object handleException(Exception e) {
        String msg = e.getMessage();
        if (msg == null || msg.equals("")) {
            msg = ResultCodeEnum.ERROR.getMsg();
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("message", msg);
        return jsonObject;
    }
}
