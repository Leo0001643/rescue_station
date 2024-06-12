package com.platform.modules.marquee.dao;
import com.platform.common.web.dao.BaseDao;
import com.platform.modules.marquee.domain.MarqueeInfo;
import org.springframework.stereotype.Repository;

@Repository
public interface MarqueeDao extends BaseDao<MarqueeInfo> {

    MarqueeInfo selectOneMarquee();
}
