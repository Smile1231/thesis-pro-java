package com.jinmao.thesisproject.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.context.WebServerInitializedEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

/**
 * @author jinmao
 * @create 2022-05-19-01:29
 * @Description
 */
@Component
@Slf4j
public class ServerConfig implements ApplicationListener<WebServerInitializedEvent> {

    @Autowired
    private Environment environment;

    @Override
    public void onApplicationEvent(WebServerInitializedEvent event) {
        Integer serverPort = event.getWebServer().getPort();
        log.info("server port {}", serverPort);
//        serverUtil.setServerPort(String.valueOf(serverPort));
    }

    public String getPort() {
        return environment.getProperty("server.port");
    }
}
