package com.jinmao.thesisproject.controller.business;

import com.jinmao.thesisproject.entity.dto.UploadFileSubmitEntity;
import com.jinmao.thesisproject.entity.vo.ResultVO;
import com.jinmao.thesisproject.service.SubmitService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author jinmao
 * @create 2022-05-19-14:51
 * @Description
 */
@Slf4j
@RequestMapping("/api/business")
@RestController
@CrossOrigin
public class SubmitController {
    @Autowired
    private SubmitService submitService;

    @PostMapping("/submit")
    public ResultVO submitAction(@RequestBody UploadFileSubmitEntity uploadFileSubmitEntity){
        log.info("start submitAction ...");
        log.info(uploadFileSubmitEntity.toString());
        return submitService.submitAction(uploadFileSubmitEntity);
//        return new ResultVO(ResultCodeEnum.OK);
    }
}
