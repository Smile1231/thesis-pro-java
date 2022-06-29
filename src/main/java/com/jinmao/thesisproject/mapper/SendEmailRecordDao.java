package com.jinmao.thesisproject.mapper;

import com.jinmao.thesisproject.entity.po.SendEmailRecord;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SendEmailRecordDao {
    int deleteByPrimaryKey(Integer id);

    int insert(SendEmailRecord record);

    int insertSelective(SendEmailRecord record);

    SendEmailRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SendEmailRecord record);

    int updateByPrimaryKey(SendEmailRecord record);
}