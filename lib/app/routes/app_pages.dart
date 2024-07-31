import 'package:common_utils/common_utils.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:rescue_station/app/modules/contacts_module/new_friend/new_friend_binding.dart';
import 'package:rescue_station/app/modules/contacts_module/new_friend/new_friend_page.dart';
import 'package:rescue_station/app/modules/message_module/chat_friend_detail/chat_friend_detail_binding.dart';
import 'package:rescue_station/app/modules/message_module/chat_friend_detail/chat_friend_detail_page.dart';
import 'package:rescue_station/app/modules/message_module/chat_group_detail/chat_group_detail_binding.dart';
import 'package:rescue_station/app/modules/message_module/chat_group_detail/chat_group_detail_page.dart';
import 'package:rescue_station/app/modules/message_module/forward_message/forward_message_binding.dart';
import 'package:rescue_station/app/modules/message_module/forward_message/forward_message_page.dart';
import 'package:rxdart/rxdart.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rescue_station/app/modules/contacts_module/group_list/group_list_binding.dart';
import 'package:rescue_station/app/modules/contacts_module/group_list/group_list_page.dart';

import '../../app/modules/contacts_module/contacts_bindings.dart';
import '../../app/modules/home_module/home_bindings.dart';
import '../../app/modules/loan_module/loan_bindings.dart';
import '../../app/modules/loan_module/loan_page.dart';
import '../../app/modules/login_module/login_bindings.dart';
import '../../app/modules/login_module/login_page.dart';
import '../../app/modules/message_module/message_bindings.dart';
import '../../app/modules/mine_module/mine_bindings.dart';
import '../../app/modules/notice_detail_module/notice_detail_bindings.dart';
import '../../app/modules/notice_detail_module/notice_detail_page.dart';
import '../../app/modules/notice_module/notice_bindings.dart';
import '../../app/modules/notice_module/notice_page.dart';
import '../../app/modules/register_module/register_bindings.dart';
import '../../app/modules/register_module/register_page.dart';
import '../../app/modules/tabs_module/tabs_binding.dart';
import '../../app/modules/tabs_module/tabs_pages.dart';
import '../modules/contacts_module/add_friend_module/add_friend_bindings.dart';
import '../modules/contacts_module/add_friend_module/add_friend_page.dart';
import '../modules/contacts_module/add_friend_module/apply_friend/apply_friend_binding.dart';
import '../modules/contacts_module/add_friend_module/apply_friend/apply_friend_page.dart';
import '../modules/contacts_module/create_group_module/create_group_bindings.dart';
import '../modules/contacts_module/create_group_module/create_group_page.dart';
import '../modules/contacts_module/friend_detail/friend_detail_binding.dart';
import '../modules/contacts_module/friend_detail/friend_detail_page.dart';
import '../modules/message_module/chat_by_friend/chat_by_friend_binding.dart';
import '../modules/message_module/chat_by_friend/chat_by_friend_page.dart';
import '../modules/message_module/chat_by_group/chat_by_group_binding.dart';
import '../modules/message_module/chat_by_group/chat_by_group_page.dart';

part './app_routes.dart';


abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.TABS,
      page: () => TabsPage(),
      binding: TabsBinding(),
      bindings: [HomeBinding(),MessageBinding(),ContactsBinding(),MineBinding()]
    ),
    // GetPage(
    //   name: Routes.HOME,
    //   page: () => HomePage(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: Routes.NOTICE,
      page: () => NoticePage(),
      binding: NoticeBinding(),
    ),
    // GetPage(
    //   name: Routes.MINE,
    //   page: () => MinePage(),
    //   binding: MineBinding(),
    // ),
    // GetPage(
    //   name: Routes.MESSAGE,
    //   page: () => MessagePage(),
    //   binding: MessageBinding(),
    // ),
    // GetPage(
    //   name: Routes.CUSTOMER_SERVICE,
    //   page: () => CustomerServicePage(),
    //   binding: CustomerServiceBinding(),
    // ),
    // GetPage(
    //   name: Routes.CONTACTS,
    //   page: () => ContactsPage(),
    //   binding: ContactsBinding(),
    // ),
    GetPage(
      name: Routes.NOTICE_DETAIL,
      page: () => NoticeDetailPage(),
      binding: NoticeDetailBinding(),
    ),
    GetPage(
      name: Routes.LOAN,
      page: () => LoanPage(),
      binding: LoanBinding(),
    ),
    GetPage(
      name: Routes.CREATE_GROUP,
      page: () => CreateGroupPage(),
      binding: CreateGroupBinding(),
    ),
    GetPage(
      name: Routes.ADD_FRIEND,
      page: () => AddFriendPage(),
      binding: AddFriendBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.CHAT_BY_FRIEND,
      page: () => ChatByFriendPage(),
      binding: ChatByFriendBinding(),
    ),
    GetPage(
      name: Routes.CHAT_BY_GROUP,
      page: () => ChatByGroupPage(),
      binding: ChatByGroupBinding(),
    ),
    GetPage(
      name: Routes.FRIEND_DETAIL,
      page: () => FriendDetailPage(),
      binding: FriendDetailBinding(),
    ),
    GetPage(
      name: Routes.NEW_FRIEND,
      page: () => NewFriendPage(),
      binding: NewFriendBinding(),
    ),
    GetPage(
      name: Routes.APPLY_FRIEND,
      page: () => ApplyFriendPage(),
      binding: ApplyFriendBinding(),
    ),
    GetPage(
      name: Routes.GROUP_LIST,
      page: () => GroupListPage(),
      binding: GroupListBinding(),
    ),
    GetPage(
      name: Routes.CHAT_FRIEND_DETAIL,
      page: () => ChatFriendDetailPage(),
      binding: ChatFriendDetailBinding(),
    ),
    GetPage(
      name: Routes.CHAT_GROUP_DETAIL,
      page: () => ChatGroupDetailPage(),
      binding: ChatGroupDetailBinding(),
    ),
    GetPage(
      name: Routes.FORWARD_MESSAGE,
      page: () => ForwardMessagePage(),
      binding: ForwardMessageBinding(),
    ),
  ];
}
