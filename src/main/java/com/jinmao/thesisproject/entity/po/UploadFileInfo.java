package com.jinmao.thesisproject.entity.po;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * upload_file_info
 * @author 
 */
@Data
public class UploadFileInfo implements Serializable {
    /**
     * 主键
     */
    private Integer id;

    /**
     * 文件类型 0 - 普通上传 ；1 - example
     */
    private Integer fileType;

    /**
     * 文件后缀
     */
    private String fileSuffix;

    /**
     * 文件唯一标识
     */
    private String fileUid;

    /**
     * 文件名
     */
    private String fileName;

    /**
     * URL
     */
    private String fileUrl;

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