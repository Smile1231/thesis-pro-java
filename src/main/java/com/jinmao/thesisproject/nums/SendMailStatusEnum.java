package com.jinmao.thesisproject.nums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author jinMao
 * @version 1.0.0
 * @ClassName SendMailStatusEnum.java
 * @Description TODO
 * @createTime 2022-06-28  17:50:00
 */
@Getter
@AllArgsConstructor
public enum SendMailStatusEnum {

    OK((byte) 0,"发送成功"),
    FAILED((byte) 1,"发送失败")
    ;

    private byte code;
    private String des;
}
