package com.jinmao.thesisproject.nums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author jinmao
 * @create 2022-05-19-22:34
 * @Description
 */
@Getter
@AllArgsConstructor
public enum FileTypeEnum {

    NORMAL(0,"Normal upload"),
    EXAMPLE(1,"Example file")
    ;

    private Integer code;
    private String des;

}
