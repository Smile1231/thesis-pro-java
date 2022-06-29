package com.jinmao.thesisproject.entity.bo;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author jinmao
 * @create 2022-06-13-21:14
 * @Description
 */
@Component
@ConfigurationProperties(prefix = "shell")
@Data
public class ShellProperties {
    private String coreFile;
    private String initShellName;
    private String zipShellName;
    private String compressedFileName;
    private String alarmEmail;
}
