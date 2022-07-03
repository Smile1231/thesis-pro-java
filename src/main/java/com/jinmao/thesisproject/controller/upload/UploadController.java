package com.jinmao.thesisproject.controller.upload;

import com.jinmao.thesisproject.entity.response.UploadRes;
import com.jinmao.thesisproject.entity.vo.ResultVO;
import com.jinmao.thesisproject.service.UploadService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author cy
 * @create 2022-05-14-16:12
 * @Description upload controller layer
 */
@Slf4j
@RestController
@RequestMapping("/api/upload")
@CrossOrigin
public class UploadController {
    @Autowired
    private UploadService uploadService;

    @PostMapping("/uploadFile")
    public ResultVO<UploadRes> uploadFile(MultipartFile file){
        log.info("start upload file ...");
        return uploadService.uploadFile(file);
//        return new ResultVO<>(ResultCodeEnum.SUCCESS);
    }

}
