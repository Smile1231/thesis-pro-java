package com.jinmao.thesisproject.entity.response;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

/**
 * @author cy
 * @create 2022-05-18-22:35
 * @Description upload pojo
 */
@Data
public class UploadRes {
    public Integer fileId;
    public String fileName;
    public String fileUrl;
}
