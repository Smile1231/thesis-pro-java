package com.jinmao.thesisproject.utils;

import com.jinmao.thesisproject.entity.bo.ShellProperties;
import com.jinmao.thesisproject.entity.po.SendEmailRecord;
import com.jinmao.thesisproject.service.SendMailService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;

/**
 * @author jinmao
 * @create 2022-06-14-23:57
 * @Description
 */
@Slf4j
@Component
public class ExecuteShellUtil {
    @Autowired
    private ShellProperties shellProperties;
    @Autowired
    private SendMailService sendMailService;
    /**
     *  run initShell script
     * @param GZFileName
     * @param GZFilUrl
     * @param XLSXFileName
     * @param XLSXFileUrl
     */
    public String initShellAction(String dirUid,String GZFileName, String GZFilUrl, String XLSXFileName, String XLSXFileUrl){
        log.info("###### init shell source info , GZFileName is {} , XLSXFileName is {} ###### ",GZFileName,XLSXFileName);
        // initShell
        Process process = null;
        try {
            ProcessBuilder pb = new ProcessBuilder();
            pb.directory(new File(DirectoryUtil.getFileLocalAbsolutePathWithFileUrl("shell/action/")));
            pb.command("chmod 777 " + shellProperties.getInitShellName());
            pb.command("./"+shellProperties.getInitShellName() ,GZFileName,GZFilUrl,XLSXFileName,XLSXFileUrl,dirUid);
            // 将错误输出流转移到标准输出流中,但使用Runtime不可以
            pb.redirectErrorStream(true);
            process = pb.start();
            String dataMsg = reader(process.getInputStream());
            log.info("###### init shell script data message is {} ###### ",dataMsg);
        } catch (IOException e) {
            log.error("######run init shell script is error , message is {}######", e.getMessage());
        }
        int runningStatus = 0;
        try {
            assert process != null;
            runningStatus = process.waitFor();
        } catch (InterruptedException e) {
            log.error("###### init shell occurs error ######", e);
        }
        if(runningStatus != 0) {
            log.error("###### init shell failed.###### ");
        }else {
            log.info("###### init shell source success. ######");
        }
        return DirectoryUtil.getComputationSourcePath(dirUid);
    }

    public void executeShell(String dirPath,String email){
        log.info("###### execute calculate shell ... ######");
        Process process = null;
        try {
            String runCommandFilePath = DirectoryUtil.getFileLocalAbsolutePathWithFileUrl(dirPath);
            ProcessBuilder processBuilder = new ProcessBuilder();
            processBuilder.directory(new File(runCommandFilePath));
            processBuilder.command("./"+ shellProperties.getCoreFile());
            // 将错误输出流转移到标准输出流中,但使用Runtime不可以
            processBuilder.redirectErrorStream(true);
            log.info("###### pb start ... ######");
            process = processBuilder.start();
            writeToLocal(runCommandFilePath + "/runLog.md",process.getInputStream());
//            String dataMsg = reader(process.getInputStream());
//            log.info("###### execute calculate shell , dataMsg is {} ######" ,dataMsg);
        } catch (IOException  e) {
            log.error("###### run calculate shell script is error , message is {} ######", e.getMessage());
            log.warn(" ###### send alarm email .... ###### ");
            sendMailService.SendMailWithAttach(buildEmailParam(dirPath,email,e.getMessage()));
            return;
        }
        try {
            assert process != null;
            process.waitFor();
        } catch (InterruptedException e) {
            log.error("###### execute shell error .###### " ,e);
            sendMailService.SendMailWithAttach(buildEmailParam(dirPath,email,e.getMessage()));
            return;
        }
            log.info("###### execute shell source success. ######");
            // zip file and send email
            zipFileAction(dirPath);
            sendMailService.SendMailWithAttach(buildEmailParam(dirPath,email));
    }
    public void zipFileAction(String computationDir){
        log.info("###### start zip file , computation is {} ###### ", computationDir);
        // initShell
        Process process = null;
        try {

            ProcessBuilder pb = new ProcessBuilder();
            pb.directory(new File(DirectoryUtil.getFileLocalAbsolutePathWithFileUrl("shell/action/")));
            pb.command("chmod 777 " + shellProperties.getZipShellName());
            pb.command("./"+shellProperties.getZipShellName() ,computationDir,shellProperties.getCompressedFileName());
            // 将错误输出流转移到标准输出流中,但使用Runtime不可以
            pb.redirectErrorStream(true);
            process = pb.start();
            writeToLocal(DirectoryUtil.getFileLocalAbsolutePathWithFileUrl(computationDir) + "/zipLog.txt",process.getInputStream());
//            String dataMsg = reader(process.getInputStream());
//            log.info("###### shell zip script data message is {} ###### ",dataMsg);
        } catch (IOException e) {
            log.error("###### run shell zip script is error , message is {}######", e.getMessage());
            log.warn(" ###### send alarm email .... ###### ");
            sendMailService.SendMailWithAttach(buildEmailParam(computationDir,"",e.getMessage()));
            return;
        }
        int runningStatus = 0;
        try {
            runningStatus = process.waitFor();
        } catch (InterruptedException e) {
            log.error("###### run shell zip script occurs error, error is {} ######", e.getMessage());
            log.warn(" ###### send alarm email .... ###### ");
            sendMailService.SendMailWithAttach(buildEmailParam(computationDir,"",e.getMessage()));
            return;
        }
        if(runningStatus != 0) {
            log.error("###### run shell zip script failed.###### ");
            log.warn(" ###### send alarm email .... ###### ");
            sendMailService.SendMailWithAttach(buildEmailParam(computationDir,"","running status not equal 0"));
        }else {
            log.info("###### run shell zip script success. ######");
        }
    }
    /**
     * 数据读取操作
     *
     * @param input 输入流
     */
    public String reader(InputStream input) {
        StringBuilder outDat = new StringBuilder();
        try (InputStreamReader inputReader = new InputStreamReader(input, StandardCharsets.UTF_8);
             BufferedReader bufferedReader = new BufferedReader(inputReader)) {
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                outDat.append(line);
                outDat.append("\n");
            }
        } catch (IOException e) {
            log.error("exception is {}", e.getMessage());
        }
        return outDat.toString();
    }

    /**
     * 将InputStream写入本地文件
     * @param destination 写入本地目录
     * @param input	输入流
     * @throws IOException
     */
    private void writeToLocal(String destination, InputStream input)
            throws IOException {
        int index;
        byte[] bytes = new byte[1024];
        FileOutputStream downloadFile = new FileOutputStream(destination);
        while ((index = input.read(bytes)) != -1) {
            downloadFile.write(bytes, 0, index);
            downloadFile.flush();
        }
        downloadFile.close();
        input.close();
    }

    public SendEmailRecord buildEmailParam(String computationDir,String email){
        SendEmailRecord sendEmailRecord = SendEmailRecord.getSendEmailRecordEntity();
        sendEmailRecord.setTo(email);
        sendEmailRecord.setComputationDirectory(computationDir);
        List<File> files = Collections.singletonList(new File(
                DirectoryUtil.getFileLocalAbsolutePathWithFileUrl(computationDir)
                        + DirectoryUtil.SLASH
                        + shellProperties.getCompressedFileName()
        ));
        sendEmailRecord.setFileList(files);
        return sendEmailRecord;
    }

    public SendEmailRecord buildEmailParam(String computationDir,String email,String errorMsg){
        SendEmailRecord sendEmailRecord = SendEmailRecord.getSendEmailRecordEntity();
        StringBuilder sb = new StringBuilder();
        sb.append("computationDirectory is " + computationDir + "\n")
          .append("to email is " + email + "\n")
          .append("errorMsg is " + errorMsg);
        sendEmailRecord.setText(sb.toString());
        sendEmailRecord.setTo(shellProperties.getAlarmEmail());
        sendEmailRecord.setComputationDirectory(computationDir);
        return sendEmailRecord;
    }
}
