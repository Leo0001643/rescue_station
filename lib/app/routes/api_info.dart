class Api{
  ///*********************HTTP协议接口***********************
  ///*************** 会员消息接口 ***************
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

  ///好友申请列表
  static const APPLY_LIST = '/apply/list';

  ///给好友发送消息
  static const CHAT_SEND_MESSAGE = '/chat/sendMsg';

  ///好友详情
  static const FRIEND_INFO = '/friend/info/';

  ///好友置顶
  static const CHAT_FRIEND_TOP = '/friend/top';


  ///文件上传
  static const FILE_UPLOAD = '/file/upload';


  ///*************** 群类消息接口 ***************
  ///建立群组
  static const CREATE_GROUP= "/group/createGroup";

  ///获取群详情
  static const GET_GROUP_INFO= "/group/getInfo/";

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
  static const LOGOUT_GROUP = "/group/logoutGroup/";

  ///解散群组
  static const REMOVE_GROUP = "/group/removeGroup/{groupId}";

///*************** 会员基础接口 ***************
  ///修改密码
  static const EDIT_PASS = "/my/editPass";

  ///退出系统
  static const LOGOUT = "/my/logout";

  ///获取会员信息
  static const GET_INFO = "/my/getInfo";

  ///修改昵称
  static const EDIT_NICK = "/my/editNick";

  ///修改头像
  static const EDIT_PORTRAIT = "/my/editPortrait";

  ///修改微聊号
  static const EDIT_CHATNO = "/my/editChatNo";

  ///修改性别
  static const EDIT_GENDER = "/my/editGender";

  ///修改个性签名
  static const EDIT_INTRO = "/my/editIntro";

  ///修改省市
  static const EDIT_CITY = "/my/editCity";

  ///修改省市
  static const EDIT_PHONE = "/my/editPhone";

  ///刷新
  static const REFRESH = "/my/refresh";

///*********************WebScoket协议接口***********************
///
}




