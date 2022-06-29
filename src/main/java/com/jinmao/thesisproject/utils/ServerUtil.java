package com.jinmao.thesisproject.utils;


import cn.hutool.core.text.StrBuilder;
import com.jinmao.thesisproject.config.ServerConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * @author jinmao
 * @create 2022-05-19-01:24
 * @Description
 */
@Component
public class ServerUtil {
    public static final String HTTP_DOUBLE_SLASH = "http://";
    public static final String COLON = ":";

    @Autowired
    private ServerConfig serverConfig;

    /**
     * 获取服务器IP
     * @return
     * @throws UnknownHostException
     */
    public String getIp() throws UnknownHostException {
        return InetAddress.getLocalHost().getHostAddress();
    }

    /**
     * 获取资源统一前缀
     * @return
     * @throws UnknownHostException
     */
    public String getFileUrlPrefix() throws UnknownHostException {
        // joint Url
        String ip = this.getIp();
        String serverPort = serverConfig.getPort();
        StrBuilder sb = new StrBuilder();
        return sb.append(ServerUtil.HTTP_DOUBLE_SLASH)
                .append(ip)
                .append(ServerUtil.COLON)
                .append(serverPort)
                .toString();
    }

    /**
     * 获取下载资源Url
     * @return
     * @throws UnknownHostException
     */
    public String getFullFileUrl(String fileUrl) throws UnknownHostException {
        return this.getFileUrlPrefix() + fileUrl;
    }

    /**
     * 获取前端返回url
     * @param fileUidName
     * @return
     */
    public  String getDownFileUrl(String fileUidName){
        return DirectoryUtil.UPLOAD_PATH + fileUidName;
    }

}
