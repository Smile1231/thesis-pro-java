package com.jinmao.thesisproject.service;

import cn.hutool.core.util.IdUtil;
import com.alibaba.fastjson.JSON;
import com.jinmao.thesisproject.check.FileVerify;
import com.jinmao.thesisproject.entity.bo.SubmitRecordFileUrlJsonObj;
import com.jinmao.thesisproject.entity.constant.Constants;
import com.jinmao.thesisproject.entity.dto.UploadFileSubmitEntity;
import com.jinmao.thesisproject.entity.po.SubmitRecordInfo;
import com.jinmao.thesisproject.entity.vo.ParamCheckVo;
import com.jinmao.thesisproject.entity.vo.ResultVO;
import com.jinmao.thesisproject.mapper.SubmitRecordInfoMapper;
import com.jinmao.thesisproject.nums.ResultCodeEnum;
import com.jinmao.thesisproject.utils.DirectoryUtil;
import com.jinmao.thesisproject.utils.ExecuteShellUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author jinmao
 * @create 2022-05-19-21:21
 * @Description
 */
@Slf4j
@Service
public class SubmitService {
    @Autowired
    private SubmitRecordInfoMapper submitRecordInfoMapper;
    @Autowired
    private ExecuteShellUtil executeShellUtil;

    public ResultVO<Object> submitAction(UploadFileSubmitEntity uploadFileSubmitEntity) {
        // check file list nums
        ParamCheckVo paramCheckVo = FileVerify.checkFileListNum(uploadFileSubmitEntity);
        if (paramCheckVo.isMistaken()){
            return new ResultVO<Object>(ResultCodeEnum.FAILED,paramCheckVo.getCheckMsg(),null);
        }
        log.info("######get exact gz and xlsx file ###### ");
        // get file
        String GZFileUrl = uploadFileSubmitEntity.getGZFileList().get(Constants.ZERO).getFileUrl();
        String XLSXFileUrl = uploadFileSubmitEntity.getXLSXFileList().get(Constants.ZERO).getFileUrl();
        //judge file if exist
        ParamCheckVo checkGZFile = FileVerify.checkFileExist(GZFileUrl);
        ParamCheckVo checkXLSXFile = FileVerify.checkFileExist(XLSXFileUrl);

        if (checkGZFile.isMistaken() || checkXLSXFile.isMistaken()){
            if (checkGZFile.isMistaken()){
                return new ResultVO<Object>(ResultCodeEnum.FAILED,checkGZFile.getCheckMsg(),null);
            }
            return new ResultVO<Object>(ResultCodeEnum.FAILED,checkXLSXFile.getCheckMsg(),null);
        }
        log.info(" ###### inset into submit record info .... ###### ");
        // insert this submits record
        SubmitRecordInfo submitRecordInfo = new SubmitRecordInfo();
        SubmitRecordFileUrlJsonObj jsonObj = new SubmitRecordFileUrlJsonObj();
        String dirUid = IdUtil.simpleUUID();

        jsonObj.setGZFileUrl(GZFileUrl);
        jsonObj.setXLSXFileUrl(XLSXFileUrl);
        jsonObj.setEmail(uploadFileSubmitEntity.getEmail());
        jsonObj.setDirUid(dirUid);
        submitRecordInfo.setFileUrl(JSON.toJSONString(jsonObj));

        submitRecordInfoMapper.insertSelective(submitRecordInfo);
        log.info("######insert successfully######");

        //start calculate business
        String GZFileName = DirectoryUtil.getFileNameByUrl(GZFileUrl);
        String XLSXFileName = DirectoryUtil.getFileNameByUrl(XLSXFileUrl);
        // init source directory
        String computationPath = executeShellUtil.initShellAction(dirUid,GZFileName, GZFileUrl, XLSXFileName, XLSXFileUrl);
        // start calculate
//        CompletableFuture.runAsync(() -> {
//            executeShellUtil.executeShell(computationPath, uploadFileSubmitEntity.getEmail());
//        }, ExecutorUtil.getExcelExecutor());

        return new ResultVO<>(ResultCodeEnum.SUCCESS);
    }

}
