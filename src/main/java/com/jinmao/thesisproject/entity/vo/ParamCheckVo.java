package com.jinmao.thesisproject.entity.vo;

import com.jinmao.thesisproject.nums.ResultCodeEnum;
import lombok.Data;


/**
 * @author jinmao
 * @create 2022-05-19-10:19
 * @Description
 */
@Data
public class ParamCheckVo {
    //false 验证通过
    private boolean mistaken;
    private String checkMsg;

    public static ParamCheckVo checkPass(){
        ParamCheckVo paramCheckVo = new ParamCheckVo();
        paramCheckVo.setMistaken(false);
        paramCheckVo.setCheckMsg(ResultCodeEnum.OK.getMsg());
        return paramCheckVo;
    }

}
