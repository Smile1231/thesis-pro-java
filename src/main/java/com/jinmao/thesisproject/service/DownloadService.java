package com.jinmao.thesisproject.service;

import cn.hutool.core.collection.CollUtil;
import com.jinmao.thesisproject.entity.constant.Constants;
import com.jinmao.thesisproject.entity.po.UploadFileInfo;
import com.jinmao.thesisproject.mapper.UploadFileInfoMapper;
import com.jinmao.thesisproject.nums.FileTypeEnum;
import com.jinmao.thesisproject.utils.DirectoryUtil;
import com.jinmao.thesisproject.utils.HttpUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.List;
import java.util.Objects;

/**
 * @author jinmao
 * @create 2022-05-19-22:27
 * @Description
 */
@Slf4j
@Service
public class DownloadService {

    @Autowired
    private UploadFileInfoMapper uploadFileInfoMapper;

    public ResponseEntity<FileSystemResource> getExampleFile(String suffix){
        // get example file
        List<UploadFileInfo> fileInfoList = uploadFileInfoMapper.getFileInfoByTypeAndSuffix(FileTypeEnum.EXAMPLE.getCode(), suffix);
        if (fileInfoList.size() >  Constants.ONE || CollUtil.isEmpty(fileInfoList)){
            log.error(" search for one example file but find InCorrectLy");
            return null;
        }
        UploadFileInfo uploadFileInfo = fileInfoList.get(Constants.ZERO);
        String filePath = DirectoryUtil.getFileLocalAbsolutePathWithFileUrl(uploadFileInfo.getFileUrl());
        log.info("download {} example file , the absolute path is {}",suffix,filePath);
        // new File
        File file = new File(filePath);
        HttpHeaders headers = HttpUtil.getInputStreamHeader(file);
        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(file.length())
                .contentType(MediaType.parseMediaType(Constants.APPLICATION_OCTET_STREAM))
                .body(new FileSystemResource(file));
    }

    /**
     * judge suffix by file name
     * @param fileName
     * @param suffix
     * @return
     */
    public boolean getFileBySuffix(String fileName,String suffix){
        return Objects.equals(DirectoryUtil.getFileSuffix(fileName),suffix);
    }
}
