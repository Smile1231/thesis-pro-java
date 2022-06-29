package com.jinmao.thesisproject.entity.bo;

import lombok.Data;
import com.jinmao.thesisproject.entity.po.SubmitRecordInfo;

/**
 * @author jinmao
 * @create 2022-05-20-21:40
 * @Description for {@link SubmitRecordInfo} fileUrl field
 */
@Data
public class SubmitRecordFileUrlJsonObj {
    private String GZFileUrl;
    private String XLSXFileUrl;
    private String email;
    private String dirUid;
}
