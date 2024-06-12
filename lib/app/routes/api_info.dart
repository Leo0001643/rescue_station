class Api{
  ///*********************HTTP协议接口***********************
  ///*************** 会员消息类别接口 ***************
  ///首页广播
  static const  MARQUEE = '/marquee/info';

  ///提交贷款申请
  static const  LOAN_APPLY = 'loan/loanApplay';

  ///会员注册
  static const  MEMBER_REGISTER = '/auth/register';

  ///会员登录
  static const  MEMBER_LOGIN = '/auth/login';

  ///搜索好友
  static const  FIND_FRIEND = '/friend/findFriend';

  ///好友列表
  static const  FRIEND_LIST = '/friend/friendList';

  ///删除好友
  static const DEL_FRIEND = '/friend/delFriend';

  ///申请添加好友
  static const APPLY_ADD = '/apply/add';

  ///通过好友申请
  static const APPLY_AGREE = '/apply/agree';

  ///忽略好友申请
  static const APPLY_IGNORE = '/apply/ignore';

  ///给好友发送消息
  static const CHAT_SEND_MESSAGE = '/chat/sendMsg';



  ///*************** 群类消息别接口 ***************
  ///建立群组
  static const CREATE_GROUP= "/group/createGroup";

  ///获取群详情
  static const GET_GROUP_INFO= "/getInfo/{groupId}";

  ///邀请进群
  static const INVITATION_GROUP= "/group/invitationGroup";

  ///加入群组
  static const JOIN_GROUP = "/group/joinGroup/{groupId}";

  ///查询群列表
  static const GROUP_LIST = "/group/groupList";

  ///发送消息
  static const GROUP_SEND_MSG = "/group/sendMsg";

  ///踢出群组
  static const KICKED_GROUP= "/group/kickedGroup";

  ///修改群名
  static const EDIT_GROUP_NAME = "/group/editGroupName";

  ///获取群组二维码
  static const GET_GROUP_QRCODE= "/group/getGroupQrCode/{groupId}";

  ///修改群公告
  static const EDIT_GROUP_NOTICE = "/group/editGroupNotice";

  ///是否置顶
  static const EDIT_TOP = "/group/editTop";

  ///是否免打扰
  static const EDIT_DISTURB = "/group/editDisturb";

  ///是否保存群组
  static const EDIT_KEEP_GROUP = "/group/editKeepGroup";

  ///退出群组
  static const LOGOUT_GROUP = "/group/logoutGroup/{groupId}";

  ///解散群组
  static const REMOVE_GROUP = "/group/removeGroup/{groupId}";





///*********************WebScoket协议接口***********************
///
}
