part of './app_pages.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

abstract class Routes {
  static const TABS = '/tabs';
  // static const HOME = '/home'; // home
  static const NOTICE = '/notice'; // Notice page
  // static const MINE = '/mine'; // Mine page
  // static const MESSAGE = '/message'; // Message page
  // static const CUSTOMER_SERVICE = '/customer_service'; // CustomerService page
  // static const CONTACTS = '/contacts'; // Contacts page
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

}




///普通事件
EventBus eventBus=EventBus();
///可用于黏性事件
EventBus behaviorBus = EventBus.customController(BehaviorSubject());


