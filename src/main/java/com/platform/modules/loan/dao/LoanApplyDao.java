package com.platform.modules.loan.dao;

import com.platform.common.web.dao.BaseDao;
import com.platform.modules.loan.domain.LoanApply;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 * 贷款申请 数据库访问层
 * q3z3
 * </p>
 */
@Repository
public interface LoanApplyDao extends BaseDao<LoanApply> {

    /**
     * 查询列表
     */
    List<LoanApply> queryList(LoanApply loanApply);

}
