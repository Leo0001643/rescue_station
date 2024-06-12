package com.platform.modules.loan.service.impl;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.platform.common.exception.BaseException;
import com.platform.common.web.service.impl.BaseServiceImpl;
import com.platform.modules.chat.dao.ChatUserDao;
import com.platform.modules.chat.domain.ChatUser;
import com.platform.modules.chat.vo.LoanApplyVo;
import com.platform.modules.loan.dao.LoanApplyDao;
import com.platform.modules.loan.domain.LoanApply;
import com.platform.modules.loan.service.LoanApplyService;
import com.platform.modules.loan.utils.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service("loanApplyService")
public class LoanApplyServiceImpl extends BaseServiceImpl<LoanApply> implements LoanApplyService {

    @Resource
    private LoanApplyDao loanApplyDao;

    @Resource
    private ChatUserDao chatUserDao;

    @Override
    public void loanApply(LoanApplyVo loanApplyVo) {
        LoanApply loanApply = new LoanApply();
        BeanUtils.copyProperties(loanApplyVo, loanApply);
        loanApply.setBillno(StringUtils.getBillno());
        loanApply.setCreateTime(new Date());
        loanApply.setUsername(loanApplyVo.getChatId());
        String chatId = loanApplyVo.getChatId();

        QueryWrapper<ChatUser> wrapper = new QueryWrapper();
        wrapper.eq("user_id", chatId);

        ChatUser chatUser = chatUserDao.selectOne(wrapper);
        Optional.ofNullable(chatUser).orElseThrow(()->new BaseException("非法申请！"));
        loanApplyDao.insert(loanApply);
    }

    @Override
    public List<LoanApply> list(LoanApplyVo loanApplyVo) {
        LoanApply loanApply = new LoanApply();
        BeanUtils.copyProperties(loanApplyVo, loanApply);
        return loanApplyDao.queryList(loanApply);
    }

    @Override
    public LoanApply getInfo(String billno) {
        LoanApply loanApply = new LoanApply();
        loanApply.setBillno(billno);
        return this.queryOne(loanApply);
    }
}
