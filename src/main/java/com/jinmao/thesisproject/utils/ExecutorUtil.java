package com.jinmao.thesisproject.utils;



import cn.hutool.core.thread.ThreadFactoryBuilder;
import org.springframework.stereotype.Component;

import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @author jinMao
 * @version 1.0.0
 * @ClassName ExecutorUtil.java
 * @Description TODO thread pool
 * @createTime 2022-06-26  15:08:00
 */
public class ExecutorUtil {
    static ThreadFactory namedThreadFactory = new ThreadFactoryBuilder()
            .setNamePrefix("Cal-shell-%d").build();
    private static ThreadPoolExecutor excelExecutor =
            new ThreadPoolExecutor(
                    5,
                    5,
                    60, TimeUnit.SECONDS,
                    new LinkedBlockingQueue<>(10000),
                    namedThreadFactory,
                    new ThreadPoolExecutor.CallerRunsPolicy());

    public static ThreadPoolExecutor getExcelExecutor(){
        return excelExecutor;
    }
}
