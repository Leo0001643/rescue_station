package com.platform.modules.loan.controller;

import com.platform.common.version.ApiVersion;
import com.platform.common.version.VersionEnum;
import com.platform.common.web.controller.BaseController;
import com.platform.common.web.domain.AjaxResult;
import com.platform.common.web.page.TableDataInfo;
import com.platform.modules.chat.service.ChatApplyService;
import com.platform.modules.chat.service.ChatFriendService;
import com.platform.modules.chat.vo.ApplyVo01;
import com.platform.modules.chat.vo.FriendVo02;
import com.platform.modules.chat.vo.LoanApplyVo;
import com.platform.modules.loan.service.LoanApplyService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * 申请
 */
@RestController
@Slf4j
@RequestMapping("/loan")
public class LoanController extends BaseController {

    @Resource
    private LoanApplyService loanApplyService;

    /**
     * 申请贷款
     */
    @ApiVersion(VersionEnum.V1_0_0)
    @PostMapping("/loanApplay")
    public AjaxResult loanApplay(@Validated @RequestBody LoanApplyVo loanApplyVo) {
        loanApplyService.loanApply(loanApplyVo);
        return AjaxResult.success();
    }

    /**
     * 申请记录
     */
    @ApiVersion(VersionEnum.V1_0_0)
    @GetMapping("/list")
    public TableDataInfo list(LoanApplyVo loanApplyVo) {
        startPage("id desc");
        return getDataTable(loanApplyService.list(loanApplyVo));
    }

    /**
     * 申请详情
     */
    @ApiVersion(VersionEnum.V1_0_0)
    @GetMapping("/info/{billno}")
    public AjaxResult getInfo(@PathVariable String billno) {
        return AjaxResult.success(loanApplyService.getInfo(billno));
    }


}
