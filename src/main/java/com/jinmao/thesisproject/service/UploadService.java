package com.jinmao.thesisproject.service;

import cn.hutool.core.util.IdUtil;
import com.jinmao.thesisproject.check.FileVerify;
import com.jinmao.thesisproject.entity.vo.ParamCheckVo;
import com.jinmao.thesisproject.mapper.UploadFileInfoMapper;
import com.jinmao.thesisproject.entity.po.UploadFileInfo;
import com.jinmao.thesisproject.nums.ResultCodeEnum;
import com.jinmao.thesisproject.entity.response.UploadRes;
import com.jinmao.thesisproject.entity.vo.ResultVO;
import com.jinmao.thesisproject.utils.DirectoryUtil;
import com.jinmao.thesisproject.utils.ServerUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Objects;

/**
 * @author jinmao
 * @create 2022-05-18-23:38
 * @Description upload service layer
 */
@Slf4j
@Service
public class UploadService{
    @Autowired
    private UploadFileInfoMapper uploadFileInfoMapper;
    @Autowired
    private ServerUtil serverUtil;

    public ResultVO<UploadRes> uploadFile(MultipartFile file){
        // get suffix
        String fileSuffix = DirectoryUtil.getFileSuffix(Objects.requireNonNull(file.getOriginalFilename()));
        ParamCheckVo paramCheckVo = FileVerify.checkUploadFile(file);
        if (paramCheckVo.isMistaken()){
            return new ResultVO<>(ResultCodeEnum.FAILED,paramCheckVo.getCheckMsg(),null);
        }
        //origin file name
        String originalFilename = file.getOriginalFilename();
        //generate uid for upload file
        String fileUid = IdUtil.simpleUUID();
        String fileUidName = DirectoryUtil.jointNewFileName(fileUid,fileSuffix);
        log.info("the new fileUidName is {}",fileUidName);
        String downFileUrl = "";
        try {
            // get upload file path
            String uploadFilePath = DirectoryUtil.getUploadFilePath();
            File uploadFile = new File(uploadFilePath + fileUidName);
            //upload
            if (!uploadFile.exists()){
                uploadFile.mkdirs();
                file.transferTo(uploadFile);
            }
            // get File Url
             downFileUrl = serverUtil.getDownFileUrl(fileUidName);
        } catch (IOException e) {
            log.error("transfer file error , the log is {}", e.getMessage());
            return new ResultVO<UploadRes>(ResultCodeEnum.ERROR);
        }
        UploadFileInfo uploadFileInfo = new UploadFileInfo();
        uploadFileInfo.setFileUid(fileUid);
        uploadFileInfo.setFileName(originalFilename);
        uploadFileInfo.setFileUrl(downFileUrl);
        uploadFileInfo.setFileSuffix(fileSuffix);
        int fileId = uploadFileInfoMapper.insertSelective(uploadFileInfo);
        log.info("insert upload file successfully !");

        log.info("start build upload response body");
        UploadRes uploadRes = new UploadRes();
        uploadRes.setFileId(fileId);
        uploadRes.setFileName(originalFilename);
        uploadRes.setFileUrl(downFileUrl);
        return new ResultVO<>(uploadRes);
    }
}
