part of './app_pages.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

abstract class Routes {
  static const TABS = '/tabs';
  // static const HOME = '/home'; // home
  static const NOTICE = '/notice'; // Notice page
  static const MINE = '/mine'; // Mine page
  static const NOTICE_DETAIL = '/notice_detail'; // NoticeDetail page
  static const LOAN = '/loan'; // Loan page
  static const CREATE_GROUP = '/create_group'; // CreateGroup page
  static const ADD_FRIEND = '/add_friend'; // AddFriend page
  static const LOGIN = '/login'; // login page
  static const REGISTER = '/register'; // register page
  static const CHAT_BY_FRIEND = '/chat_by_friend'; // friend chat page
  static const CHAT_BY_GROUP = '/chat_by_group'; // group chat page
  static const FRIEND_DETAIL = '/friend_detail'; // friend detail page
  static const NEW_FRIEND = '/new_friend'; // new friend
  static const APPLY_FRIEND = '/apply_friend'; // apply friend
  static const GROUP_LIST = '/group_list'; // group list
  static const NICK_NAME_EDIT = '/nick_name_edit';// NickNameEdit page
  static const CHAT_FRIEND_DETAIL = '/chat_friend_detail';// chat friend detail
  static const CHAT_GROUP_DETAIL = '/chat_group_detail';// chat group detail
  static const FORWARD_MESSAGE = '/forward_message';// forward message
  static const EDIT_GROUP_NAME = '/edit_group_name';// edit group name
  static const GROUP_ADD = '/group_add';// group add
  static const GROUP_REDUCE = '/group_reduce';// group reduce
  static const MY_REFRESH = 'my/refresh';
  static const EDIT_PWD = '/pwd_edit';
  static const EDIT_CHATNO = '/editChatNo'; // ChatnoEdit page
  static const EDIT_PHONE = '/edit_phone'; // phone_edit page
  static const EDIT_ADDR = '/edit_addr'; // addrEdit page
}


void showToasty(String? msg){
  if(ObjectUtil.isEmpty(msg)) return;
  GFToast.showToast(msg, Get.context!, toastPosition: GFToastPosition.BOTTOM);
}


///普通事件
EventBus eventBus=EventBus();
///可用于黏性事件
EventBus behaviorBus = EventBus.customController(BehaviorSubject());

/// Checks if string is URL.
bool isURL(String s) => s.startsWith("http");


bool isEmpty(Object? any){
  return ObjectUtil.isEmpty(any) || any == 'null';
}

bool isNotEmpty(Object? any){
  return ObjectUtil.isNotEmpty(any) && any != 'null';
}
