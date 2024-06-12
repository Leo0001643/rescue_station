package com.platform.modules.marquee.domain;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 广播信息表
 * @TableName marquee_info
 */
@Data
public class MarqueeInfo implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 广播信息
     */
    private String content;

    /**
     * 添加时间
     */
    private Date createTime;

    private static final long serialVersionUID = 1L;
}