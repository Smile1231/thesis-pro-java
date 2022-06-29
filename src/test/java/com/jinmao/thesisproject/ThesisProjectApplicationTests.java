package com.jinmao.thesisproject;

import cn.hutool.core.util.IdUtil;
import com.alibaba.fastjson.JSON;
import com.jinmao.thesisproject.entity.bo.ShellProperties;
import com.jinmao.thesisproject.entity.bo.SubmitRecordFileUrlJsonObj;
import com.jinmao.thesisproject.entity.po.SendEmailRecord;
import com.jinmao.thesisproject.entity.po.SubmitRecordInfo;
import com.jinmao.thesisproject.service.SendMailService;
import com.jinmao.thesisproject.utils.DirectoryUtil;
import com.jinmao.thesisproject.utils.ExecuteShellUtil;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

@SpringBootTest
class ThesisProjectApplicationTests {

    @Autowired
    private ExecuteShellUtil executeShellUtil;
    @Autowired
    private ShellProperties shellProperties;
    @Autowired
    private SendMailService sendMailService;


    @Test
    void contextLoads() {
        System.out.println(DirectoryUtil.getLocalDir());
    }

    public static void main(String[] args) {
//        String fileName = "test.fq.gz";
//        String fileSuffix = fileName.substring(fileName.lastIndexOf(".")+1);
//        System.out.println(fileSuffix);

        SubmitRecordInfo submitRecordInfo = new SubmitRecordInfo();
        SubmitRecordFileUrlJsonObj jsonObj = new SubmitRecordFileUrlJsonObj();
        jsonObj.setGZFileUrl("/upload/97706bc6d93b4d42add3780f1cc24f65.gz");
        jsonObj.setXLSXFileUrl("/upload/f809d7ae27b74e82bee6aedb8d3246a1.xlsx");

        submitRecordInfo.setFileUrl(JSON.toJSONString(jsonObj));

        System.out.println(submitRecordInfo);

    }

    @Test
    void context01(){
        executeShellUtil.executeShell("",shellProperties.getCoreFile());
    }

    @Test
    void context02() throws IOException {
//        ProcessBuilder pb = new ProcessBuilder("./test.sh");
//        pb.directory(new File(DirectoryUtil.getLocalDir()+"/pro/watchdog/"));

        ProcessBuilder pb = new ProcessBuilder();
        pb.command("./pro/watchdog/test.sh");

        Process process = pb.start();

        ExecuteShellUtil executeShellUtil1 = new ExecuteShellUtil();
        String reader = executeShellUtil1.reader(process.getInputStream());

        System.out.println("....");
    }

    @Test
    void context03() throws IOException {
        ProcessBuilder pb = new ProcessBuilder();
        pb.command("./" + "initShell.sh",
                "bb57aae49d67496f8117ecbab9256334.fq.gz",
                "upload/bb57aae49d67496f8117ecbab9256334.fq.gz",
                "e03b1340d87445d796b4899feddd222c.xlsx",
                "upload/e03b1340d87445d796b4899feddd222c.xlsx");
        pb.directory(new File(DirectoryUtil.getAbsoluteResourcesPath()+"/shell/action"));

        Process process = pb.start();
        ExecuteShellUtil executeShellUtil1 = new ExecuteShellUtil();
        String reader = executeShellUtil1.reader(process.getInputStream());
        System.out.println(reader);
        System.out.println("....");
    }

    @Test
    void content04(){
        String GZFileUrl = "upload/bb57aae49d67496f8117ecbab9256334.fq.gz";
        String XLSXFileUrl = "upload/e03b1340d87445d796b4899feddd222c.xlsx";

        String gzFileName = DirectoryUtil.getFileNameByUrl(GZFileUrl);
        String XlsxFileName = DirectoryUtil.getFileNameByUrl(XLSXFileUrl);

        System.out.println(executeShellUtil.initShellAction("",gzFileName, GZFileUrl, XlsxFileName, XLSXFileUrl));
    }

    @Test
    void context05(){
        System.out.println(IdUtil.simpleUUID());
    }

    @Test
    void context06(){
        String GZFileUrl = "upload/bb57aae49d67496f8117ecbab9256334.fq.gz";
        String XLSXFileUrl = "upload/e03b1340d87445d796b4899feddd222c.xlsx";

        String gzFileName = DirectoryUtil.getFileNameByUrl(GZFileUrl);
        String XlsxFileName = DirectoryUtil.getFileNameByUrl(XLSXFileUrl);
//        executeShellUtil.executeShell(executeShellUtil.initShellAction(gzFileName, GZFileUrl, XlsxFileName, XLSXFileUrl));
        executeShellUtil.initShellAction(IdUtil.simpleUUID(),gzFileName, GZFileUrl, XlsxFileName, XLSXFileUrl);
    }

    @Test
    void context07(){
        SendEmailRecord sendEmailRecordEntity = SendEmailRecord.getSendEmailRecordEntity();

        ArrayList<File> files = new ArrayList<>();
        files.add(new File("/Users/jinmao/Documents/IDEASpace/thesis-project/src/main/resources/computation/189e0cd03b8c4ca9889352321980aa7d/coreCalFile.sh"));

        sendEmailRecordEntity.setFileList(files);
        sendEmailRecordEntity.setTo("992774731@qq.com");

        sendMailService.SendMailWithAttach(sendEmailRecordEntity);
    }

    @Test
    void testExecuteShell(){
        executeShellUtil.executeShell("computation/851cfc59310d4718908306acf6fb8b11","992774731@qq.com");
    }

}
