package com.jinmao.thesisproject.controller.business;

import com.jinmao.thesisproject.service.DownloadService;
import com.jinmao.thesisproject.utils.DirectoryUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author jinmao
 * @create 2022-05-19-22:06
 * @Description
 */
@Slf4j
@RestController
@RequestMapping("/api/download")
@CrossOrigin
public class DownloadController {
    @Autowired
    private DownloadService downloadService;

    @PostMapping("/GZExampleFile")
    @CrossOrigin
    public ResponseEntity<FileSystemResource> getGZExampleFile(){
        log.info("start download GZExampleFile !");
        return downloadService.getExampleFile(DirectoryUtil.GZ);
    }

    @PostMapping("/XLSXExampleFile")
    @CrossOrigin
    public ResponseEntity<FileSystemResource> getXLSXExampleFile(){
        log.info("start download XLSXExampleFile !");
        return downloadService.getExampleFile(DirectoryUtil.XLSX);
    }
}
