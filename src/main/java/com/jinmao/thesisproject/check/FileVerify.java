package com.jinmao.thesisproject.check;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.jinmao.thesisproject.entity.constant.Constants;
import com.jinmao.thesisproject.entity.dto.UploadFileSubmitEntity;
import com.jinmao.thesisproject.entity.response.UploadRes;
import com.jinmao.thesisproject.entity.vo.ParamCheckVo;
import com.jinmao.thesisproject.utils.ConversionUtil;
import com.jinmao.thesisproject.utils.DirectoryUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.Objects;

/**
 * @author jinmao
 * @create 2022-05-19-10:18
 * @Description verify file roles
 */
@Slf4j
public class FileVerify {


    public static ParamCheckVo checkUploadFile(MultipartFile file) {
        ParamCheckVo paramCheckVo = ParamCheckVo.checkPass();
        String fileSuffix = DirectoryUtil.getFileSuffix(Objects.requireNonNull(file.getOriginalFilename()));
        if (!Objects.equals(fileSuffix, DirectoryUtil.XLSX) && !Objects.equals(fileSuffix, DirectoryUtil.GZ)) {
            paramCheckVo.setMistaken(true);
            paramCheckVo.setCheckMsg(" you can only upload `.xlsx` or `.gz` file !");
            return paramCheckVo;
        }
        Long sizeOfMB = ConversionUtil.byte2MB(file.getSize());
        log.info("the size of file is {} MB ",sizeOfMB);
        if (sizeOfMB > Constants.MAX_UPLOAD_FILE ){
            paramCheckVo.setMistaken(true);
            paramCheckVo.setCheckMsg(" the file size is to big , plz batch upload !");
            return paramCheckVo;
        }
        return paramCheckVo;
    }


    public static ParamCheckVo checkFileListNum(UploadFileSubmitEntity uploadFileSubmitEntity){
        ParamCheckVo paramCheckVo = ParamCheckVo.checkPass();
        ArrayList<UploadRes> gzFileList = uploadFileSubmitEntity.getGZFileList();
        ArrayList<UploadRes> xlsxFileList = uploadFileSubmitEntity.getXLSXFileList();
        if (CollUtil.isEmpty(gzFileList) || gzFileList.size() > Constants.ONE){
            paramCheckVo.setMistaken(true);
            paramCheckVo.setCheckMsg("`gz` file can not empty and can only upload one !");
            return paramCheckVo;
        }
        if (CollUtil.isEmpty(xlsxFileList) || xlsxFileList.size() > Constants.ONE){
            paramCheckVo.setMistaken(true);
            paramCheckVo.setCheckMsg("`xlsx` file can not empty and  can only upload one !");
            return paramCheckVo;
        }
        if (StrUtil.isBlank(uploadFileSubmitEntity.getEmail())){
            paramCheckVo.setMistaken(true);
            paramCheckVo.setCheckMsg("eamil param can not be empty ..");
            return paramCheckVo;
        }
        return paramCheckVo;
    }

    public static ParamCheckVo checkFileExist(String fileUrl){
        ParamCheckVo paramCheckVo = ParamCheckVo.checkPass();
        String filePath = DirectoryUtil.getFileLocalAbsolutePathWithFileUrl(fileUrl);
        File file = new File(filePath);
        if (!file.exists()){
            paramCheckVo.setMistaken(true);
            log.warn(" file is not exist , fileUrl is {} ",fileUrl);
            paramCheckVo.setCheckMsg(" file is not exist , fileUrl is "+ fileUrl + " , Plz check .");
            return paramCheckVo;
        }
        return paramCheckVo;
    }

}
