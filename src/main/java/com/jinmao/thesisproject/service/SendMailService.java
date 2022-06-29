package com.jinmao.thesisproject.service;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.jinmao.thesisproject.entity.bo.ShellProperties;
import com.jinmao.thesisproject.entity.po.SendEmailRecord;
import com.jinmao.thesisproject.mapper.SendEmailRecordDao;
import com.jinmao.thesisproject.nums.SendMailStatusEnum;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import java.io.File;
import java.util.Objects;

/**
 * @author jinMao
 * @version 1.0.0
 * @ClassName SendMailService.java
 * @Description TODO Send Email
 * @createTime 2022-06-27  09:15:00
 */
@Slf4j
@Component
public class SendMailService {
    @Autowired
    private JavaMailSenderImpl mailSender;//注入邮件工具类
    @Autowired
    private SendEmailRecordDao sendEmailRecordDao;
    @Autowired
    private ShellProperties shellProperties;

    public void SendMailWithAttach(SendEmailRecord sendEmailInfo){
        try {
            log.info("start to send email to {}",sendEmailInfo.getTo());
            MimeMessageHelper messageHelper = new MimeMessageHelper(mailSender.createMimeMessage(), true);//true表示支持复杂类型
            sendEmailInfo.setFrom(getMailSendFrom());//邮件发信人从配置项读取
            messageHelper.setFrom(sendEmailInfo.getFrom());//邮件发信人
            messageHelper.setTo(sendEmailInfo.getTo().split(","));//邮件收信人
            messageHelper.setSubject(sendEmailInfo.getSubject());//邮件主题
            messageHelper.setText(sendEmailInfo.getText());//邮件内容
            if (StrUtil.isNotBlank(sendEmailInfo.getCc())) {//抄送
                messageHelper.setCc(sendEmailInfo.getCc().split(","));
            }
            if (StrUtil.isNotBlank(sendEmailInfo.getBcc())) {//密送
                messageHelper.setCc(sendEmailInfo.getBcc().split(","));
            }
            if (CollUtil.isNotEmpty(sendEmailInfo.getFileList())) {//添加邮件附件
                for (File file : sendEmailInfo.getFileList()) {
                    messageHelper.addAttachment(file.getName(),file);
                }
            }
            mailSender.send(messageHelper.getMimeMessage());//正式发送邮件
            sendEmailInfo.setStatus(SendMailStatusEnum.OK.getCode());
            log.info("Send Email Success ：{}->{}", sendEmailInfo.getFrom(), sendEmailInfo.getTo());
        } catch (Exception e) {
            log.error("send Email failed , error is {}",e.getMessage());
            sendEmailInfo.setStatus(SendMailStatusEnum.FAILED.getCode());
            sendEmailInfo.setError(e.getMessage());
        }finally {
            saveMail(sendEmailInfo);
        }
    }

    //保存邮件
    private void saveMail(SendEmailRecord emailInfo) {
        log.info("start save send email record to database.");
        if (Objects.equals(emailInfo.getTo(),shellProperties.getAlarmEmail())){
            log.info("this is alarm email , email info is {}",emailInfo);
            emailInfo.setStatus(SendMailStatusEnum.FAILED.getCode());
        }
        sendEmailRecordDao.insertSelective(emailInfo);
    }

    //获取邮件发信人
    public String getMailSendFrom() {
        return mailSender.getJavaMailProperties().getProperty("from");
    }
}
