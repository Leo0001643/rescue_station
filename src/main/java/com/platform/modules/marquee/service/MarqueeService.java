package com.platform.modules.marquee.service;

import com.platform.common.web.service.BaseService;
import com.platform.modules.marquee.domain.MarqueeInfo;

public interface MarqueeService  extends BaseService<MarqueeInfo> {
    /**
     * 获取广播信息
     */
    MarqueeInfo info();

}
