package com.jinmao.thesisproject.entity.vo;

import com.jinmao.thesisproject.nums.ResultCodeEnum;
import lombok.Data;
import lombok.Getter;

/**
 * @author cy
 * @create 2022-05-18-22:18
 * @Description 统一消息返回体
 */
@Data
public class ResultVO<T> {

    /**
     * 状态码，比如200代表响应成功
     */
    private Integer code;
    /**
     * 响应信息，用来说明响应情况
     */
    private String msg;
    /**
     * 响应的具体数据
     */
    private T data;

    //构造返回 --无参
    public ResultVO(ResultCodeEnum code){
        this(code,null);
    }

    //构造返回成功参数--有参
    public ResultVO(T data) {
        this(ResultCodeEnum.SUCCESS, data);
    }

    public ResultVO(ResultCodeEnum resultCodeEnum, T data) {
        this.code = resultCodeEnum.getCode();
        this.msg = resultCodeEnum.getMsg();
        this.data = data;
    }

    public ResultVO(ResultCodeEnum resultCodeEnum, String msg , T data){
        this.code = resultCodeEnum.getCode();
        this.msg = msg;
        this.data = data;
    }

}

