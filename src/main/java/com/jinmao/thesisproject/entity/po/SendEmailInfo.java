package com.jinmao.thesisproject.entity.po;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

/**
 * @author jinMao
 * @version 1.0.0
 * @ClassName EmailVo.java
 * @Description TODO send email entity
 * @createTime 2022-06-27  09:20:00
 */
@Data
public class SendEmailInfo {
    private Integer id;//邮件id
    private String from;//邮件发送人
    private String to;//邮件接收人（多个邮箱则用逗号","隔开）
    private String subject;//邮件主题
    private String text;//邮件内容
    private Date sentDate;//发送时间
    private String cc;//抄送（多个邮箱则用逗号","隔开）
    private String bcc;//密送（多个邮箱则用逗号","隔开）
    private String status;//状态
    private String error;//报错信息
    @JsonIgnore
    private MultipartFile[] multipartFiles;//邮件附件
}
