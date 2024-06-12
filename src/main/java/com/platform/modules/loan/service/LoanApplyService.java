package com.platform.modules.loan.service;
import com.platform.common.web.service.BaseService;
import com.platform.modules.chat.vo.LoanApplyVo;
import com.platform.modules.loan.domain.LoanApply;

import java.util.List;

public interface LoanApplyService extends BaseService<LoanApply> {
    
    void loanApply(LoanApplyVo loanApplyVo);

    List<LoanApply> list(LoanApplyVo loanApplyVo);

    LoanApply getInfo(String billno);
}
