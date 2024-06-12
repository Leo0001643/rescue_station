package com.platform.modules.chat.vo;
import lombok.Data;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Data
public class LoanApplyVo {

//            `chat_id` bigint DEFAULT NULL COMMENT '账号ID',
//            `billno` bigint DEFAULT NULL COMMENT '申请单号',
//            `username` varchar(20) DEFAULT NULL COMMENT '会员名',
//            `realname` varchar(10) DEFAULT NULL COMMENT '真实姓名',
//            `phone` varchar(13) DEFAULT NULL COMMENT '手机号',
//            `identity_id` varchar(60) DEFAULT NULL COMMENT '身份证号',
//            `home_address` varchar(60) DEFAULT NULL COMMENT '家庭住址',
//            `home_revenue` decimal(11,2) DEFAULT NULL COMMENT '家庭月收入',
//            `loan_amount` decimal(11,2) DEFAULT NULL COMMENT '贷款金额',
//            `reason` varchar(200) DEFAULT NULL COMMENT '理由',
//            `create_time` datetime DEFAULT NULL COMMENT '申请时间',


    @NotNull(message = "账号不能为空")
    private String chatId;

    @NotNull(message = "真实姓名不能为空")
    private String realname;

    @NotNull(message = "手机号不能为空")
    private String phone;

    @NotNull(message = "身份证号码不能为空")
    private String identityId;

    @NotNull(message = "家庭住址不能为空")
    private String homeAddress;

    @NotNull(message = "家庭月收入不能为空")
    private BigDecimal homeRevenue;

    @NotNull(message = "贷款金额不能为空")
    private BigDecimal loanAmount;

    @NotNull(message = "申请原因不能为空")
    private String reason;

}
