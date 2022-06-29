package com.jinmao.thesisproject.entity.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.jinmao.thesisproject.entity.response.UploadRes;
import lombok.Data;

import java.util.ArrayList;

/**
 * @author jinmao
 * @create 2022-05-19-15:05
 * @Description
 */
@Data
public class UploadFileSubmitEntity {
    //gz 文件列表
    @JsonProperty("GZFileList")
    private ArrayList<UploadRes> GZFileList;
    //xlsx 文件列表
    @JsonProperty("XLSXFileList")
    private ArrayList<UploadRes> XLSXFileList;
    @JsonProperty("email")
    private String email;
}
