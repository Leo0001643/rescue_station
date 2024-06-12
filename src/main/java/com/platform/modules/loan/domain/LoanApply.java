package com.platform.modules.loan.domain;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 贷款申请表
 * @TableName loan_apply
 */
@Data
public class LoanApply implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 账号ID
     */
    private String chatId;

    /**
     * 申请单号
     */
    private String billno;

    /**
     * 会员名
     */
    private String username;

    /**
     * 真实姓名
     */
    private String realname;

    /**
     * 手机号
     */
    private String phone;

    /**
     * 身份证号
     */
    private String identityId;

    /**
     * 家庭住址
     */
    private String homeAddress;

    /**
     * 家庭月收入
     */
    private BigDecimal homeRevenue;

    /**
     * 贷款金额
     */
    private BigDecimal loanAmount;

    /**
     * 理由
     */
    private String reason;

    /**
     * 申请时间
     */
    private Date createTime;

    private static final long serialVersionUID = 1L;
}