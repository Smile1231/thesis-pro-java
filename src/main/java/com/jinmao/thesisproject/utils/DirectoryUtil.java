package com.jinmao.thesisproject.utils;

import com.jinmao.thesisproject.entity.constant.Constants;
import lombok.extern.slf4j.Slf4j;

import java.util.Objects;


/**
 * @author cy
 * @create 2022-05-18-23:00
 * @Description 文件目录工具类
 */
@Slf4j
public class DirectoryUtil {
    public static final String LOCAL_PATH = "/src/main/resources";
    public static final String UPLOAD_PATH = "upload/";
    public static final String SLASH = "/";
    public static final String XLSX = "xlsx";
    public static final String GZ = "gz";
    public static final String POINT = ".";
    public static final String FQ = "fq";
    public static final String COMPUTATION = "computation";

    public static String getFileSuffix(String fileName){
        return fileName.substring(fileName.lastIndexOf(".") + Constants.ONE );
    }

    /**
     * 获取项目地址
     * @return
     */
    public static String getLocalDir() {
        return System.getProperty("user.dir");
    }

    /**
     *
     * @return 获取文件上传的目录
     */
    public static String getUploadFilePath(){
        return getLocalDir() + LOCAL_PATH + SLASH + UPLOAD_PATH;
    }

    /**
     * get resource path
     * @return
     */
    public static String getAbsoluteResourcesPath(){
        return getLocalDir() + LOCAL_PATH ;
    }

    public static String getFileLocalAbsolutePathWithFileName(String fileName){
        return getUploadFilePath() + fileName;
    }

    public static String getFileLocalAbsolutePathWithFileUrl(String fileUrl){
        return getAbsoluteResourcesPath() + DirectoryUtil.SLASH + fileUrl;
    }

    public static String jointNewFileName(String fileUid , String fileSuffix){
        if (Objects.equals(fileSuffix,XLSX)){
            return fileUid + DirectoryUtil.POINT + fileSuffix;
        }
        return fileUid + DirectoryUtil.POINT + DirectoryUtil.FQ + DirectoryUtil.POINT + fileSuffix;
    }

    /**
     * according to front fileUrl get file name
     * upload/bb57aae49d67496f8117ecbab9256334.fq.gz
     * @return
     */
    public static String getFileNameByUrl(String fileUrl){
        return fileUrl.substring(7,fileUrl.length());
    }

    public static String getComputationSourcePath(String uidDirName){
        log.info("###### computation path is {} ######",uidDirName);
        return COMPUTATION + SLASH + uidDirName;
    }

}
