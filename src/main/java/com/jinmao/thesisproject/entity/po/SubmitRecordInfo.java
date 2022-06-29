package com.jinmao.thesisproject.entity.po;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * submit_record_info
 * @author 
 */
@Data
public class SubmitRecordInfo implements Serializable {
    /**
     * 主键
     */
    private Integer id;

    /**
     * URL信息JSON
     */
    private Object fileUrl;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;

    private static final long serialVersionUID = 1L;
}