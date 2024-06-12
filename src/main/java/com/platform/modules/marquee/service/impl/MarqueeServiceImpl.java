package com.platform.modules.marquee.service.impl;
import com.platform.common.web.service.impl.BaseServiceImpl;
import com.platform.modules.marquee.dao.MarqueeDao;
import com.platform.modules.marquee.domain.MarqueeInfo;
import com.platform.modules.marquee.service.MarqueeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("marqueeService")
public class MarqueeServiceImpl extends BaseServiceImpl<MarqueeInfo> implements MarqueeService {
    @Resource
    private MarqueeDao marqueeDao;
    @Override
    public MarqueeInfo info() {
        return marqueeDao.selectOneMarquee();
    }
}
