package com.jinmao.thesisproject.entity.po;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import java.io.File;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * send_email_record
 * @author 
 */
@Data
public class SendEmailRecord implements Serializable {
    /**
     * 主键
     */
    private Integer id;

    /**
     * 邮件发送人
     */
    private String from;

    /**
     * 邮件接受人
     */
    private String to;

    /**
     * 邮件主题
     */
    private String subject;

    /**
     * 邮件内容
     */
    private String text;

    /**
     * 抄送
     */
    private String cc;

    /**
     * 密送
     */
    private String bcc;

    /**
     * 0 - ok , 1 - fail
     */
    private Byte status;

    /**
     * 报错信息
     */
    private String error;

    /**
     * 发送时间
     */
    private Date sendDate;

    /**
     * 计算文件夹路径
     */
    private String computationDirectory;

    /**
     * 邮件附件
     */
    @JsonIgnore
    private List<File> fileList;

    public static SendEmailRecord getSendEmailRecordEntity(){
        SendEmailRecord sendEmailRecord = new SendEmailRecord();
        sendEmailRecord.setSubject("⭐️ Your Calculate Result ⭐️");
        sendEmailRecord.setText("Thank you for using ... now you can download attachment to get your result 💫.");

        return sendEmailRecord;
    }

    private static final long serialVersionUID = 1L;
}