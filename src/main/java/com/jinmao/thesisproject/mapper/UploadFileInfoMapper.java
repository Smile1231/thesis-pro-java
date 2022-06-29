package com.jinmao.thesisproject.mapper;

import com.jinmao.thesisproject.entity.po.UploadFileInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UploadFileInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UploadFileInfo record);

    int insertSelective(UploadFileInfo record);

    UploadFileInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UploadFileInfo record);

    int updateByPrimaryKey(UploadFileInfo record);

    List<UploadFileInfo> getFileInfoByTypeAndSuffix(@Param("fileType") Integer fileType, @Param("fileSuffix") String suffix);
}