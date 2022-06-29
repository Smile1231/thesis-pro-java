package com.jinmao.thesisproject.config;

import com.jinmao.thesisproject.utils.DirectoryUtil;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author jinmao
 * @create 2022-05-19-01:20
 * @Description
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String path = DirectoryUtil.getUploadFilePath();
        //registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");
        //linux服务器文件目录
        //配置磁盘映射 , pathPattern  访问路径                                        磁盘映射路径，不然不能够访问
        //这是因为对服务器的保护措施导致的，服务器不能对外部暴露真实的资源路径，需要配置虚拟路径映射访问。
        registry.addResourceHandler("/upload/**").addResourceLocations("file:" + path);
    }

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        //添加映射路径
        registry.addMapping("/**")
                //是否发送Cookie
                .allowCredentials(true)
                //设置放行哪些原始域   SpringBoot2.4.4下低版本使用.allowedOrigins("*")
                .allowedOrigins("*")
                //放行哪些请求方式
//                .allowedMethods(new String[]{"GET", "POST", "PUT", "DELETE"})
                .allowedMethods("*") //或者放行全部
        ;
    }
}
