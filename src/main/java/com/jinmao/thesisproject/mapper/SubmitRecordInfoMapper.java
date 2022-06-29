package com.jinmao.thesisproject.mapper;

import com.jinmao.thesisproject.entity.po.SubmitRecordInfo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SubmitRecordInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SubmitRecordInfo record);

    int insertSelective(SubmitRecordInfo record);

    SubmitRecordInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SubmitRecordInfo record);

    int updateByPrimaryKey(SubmitRecordInfo record);
}