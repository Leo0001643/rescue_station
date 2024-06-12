package com.platform.modules.marquee.controller;

import com.platform.common.aspectj.IgnoreAuth;
import com.platform.common.version.ApiVersion;
import com.platform.common.version.VersionEnum;
import com.platform.common.web.controller.BaseController;
import com.platform.common.web.domain.AjaxResult;
import com.platform.common.web.page.TableDataInfo;
import com.platform.modules.chat.vo.LoanApplyVo;
import com.platform.modules.loan.service.LoanApplyService;
import com.platform.modules.marquee.service.MarqueeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * 申请
 */
@RestController
@Slf4j
@RequestMapping("/marquee")
public class MarqueeController extends BaseController {
    @Resource
    private MarqueeService marqueeService;

    /**
     * 获取广播信息
     */
    @IgnoreAuth
    @ApiVersion(VersionEnum.V1_0_0)
    @GetMapping("/info")
    public AjaxResult info() {
        return AjaxResult.success(marqueeService.info());
    }

}
