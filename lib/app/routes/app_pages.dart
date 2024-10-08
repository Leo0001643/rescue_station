import 'package:common_utils/common_utils.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:getwidget/getwidget.dart';
import '../modules/contacts_module/group_add/group_add_binding.dart';
import '../modules/contacts_module/group_add/group_add_page.dart';
import '../modules/contacts_module/group_list/group_list_binding.dart';
import '../modules/contacts_module/group_list/group_list_page.dart';
import '../modules/contacts_module/group_reduce/group_reduce_binding.dart';
import '../modules/contacts_module/group_reduce/group_reduce_page.dart';
import '../modules/contacts_module/new_friend/new_friend_binding.dart';
import '../modules/contacts_module/new_friend/new_friend_page.dart';
import '../modules/message_module/chat_friend_detail/chat_friend_detail_binding.dart';
import '../modules/message_module/chat_friend_detail/chat_friend_detail_page.dart';
import '../modules/message_module/chat_group_detail/chat_group_detail_binding.dart';
import '../modules/message_module/chat_group_detail/chat_group_detail_page.dart';
import '../modules/message_module/edit_group_name/edit_group_name_binding.dart';
import '../modules/message_module/edit_group_name/edit_group_name_page.dart';
import '../modules/message_module/forward_message/forward_message_binding.dart';
import '../modules/message_module/forward_message/forward_message_page.dart';
import '../modules/mine_module/addr_edit_module/addr_edit_bindings.dart';
import '../modules/mine_module/addr_edit_module/addr_edit_page.dart';
import '../modules/mine_module/chatNo_edit_module/chatNo_edit_bindings.dart';
import '../modules/mine_module/chatNo_edit_module/chatNo_edit_page.dart';
import '../modules/mine_module/phone_edit_module/phone_edit_bindings.dart';
import '../modules/mine_module/phone_edit_module/phone_edit_page.dart';
import '../modules/mine_module/pwd_edit_module/pwd_edit_bindings.dart';
import '../modules/mine_module/pwd_edit_module/pwd_edit_page.dart';
import '../modules/mine_module/nick_name_edit_module/nick_name_edit_page.dart';
import '../modules/mine_module/nick_name_edit_module/nick_name_edit_bindings.dart';
import '../modules/contacts_module/contacts_bindings.dart';
import '../modules/home_module/home_bindings.dart';
import '../modules/loan_module/loan_bindings.dart';
import '../modules/loan_module/loan_page.dart';
import '../modules/login_module/login_bindings.dart';
import '../modules/login_module/login_page.dart';
import '../modules/message_module/message_bindings.dart';
import '../modules/mine_module/mine_bindings.dart';
import '../modules/notice_detail_module/notice_detail_bindings.dart';
import '../modules/notice_detail_module/notice_detail_page.dart';
import '../modules/notice_module/notice_bindings.dart';
import '../modules/notice_module/notice_page.dart';
import '../modules/register_module/register_bindings.dart';
import '../modules/register_module/register_page.dart';
import '../modules/tabs_module/tabs_binding.dart';
import '../modules/tabs_module/tabs_pages.dart';
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
import '../modules/mine_module/mine_page.dart';
part './app_routes.dart';


abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.TABS,
      page: () => const TabsPage(),
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
    GetPage(
      name: Routes.MINE,
      page: () => MinePage(),
      binding: MineBinding(),
    ),
    // GetPage(
    //   name: Routes.MESSAGE,
    //   page: () => MessagePage(),
    //   binding: MessageBinding(),
    // ),
    // GetPage(
    //   name: Routes.CONTACTS,
    //   page: () => ContactsPage(),
    //   binding: ContactsBinding(),
    // ),
    GetPage(
      name: Routes.NOTICE_DETAIL,
      page: () => const NoticeDetailPage(),
      binding: NoticeDetailBinding(),
    ),
    GetPage(
      name: Routes.LOAN,
      page: () => const LoanPage(),
      binding: LoanBinding(),
    ),
    GetPage(
      name: Routes.CREATE_GROUP,
      page: () => const CreateGroupPage(),
      binding: CreateGroupBinding(),
    ),
    GetPage(
      name: Routes.ADD_FRIEND,
      page: () => const AddFriendPage(),
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
      name: Routes.CHAT_BY_FRIEND,
      page: () => const ChatByFriendPage(),
      binding: ChatByFriendBinding(),
    ),
    GetPage(
      name: Routes.CHAT_BY_GROUP,
      page: () => const ChatByGroupPage(),
      binding: ChatByGroupBinding(),
    ),
    GetPage(
      name: Routes.FRIEND_DETAIL,
      page: () => const FriendDetailPage(),
      binding: FriendDetailBinding(),
    ),
    GetPage(
      name: Routes.NEW_FRIEND,
      page: () => const NewFriendPage(),
      binding: NewFriendBinding(),
    ),
    GetPage(
      name: Routes.APPLY_FRIEND,
      page: () => const ApplyFriendPage(),
      binding: ApplyFriendBinding(),
    ),
    GetPage(
      name: Routes.GROUP_LIST,
      page: () => const GroupListPage(),
      binding: GroupListBinding(),
    ),
    GetPage(
      name: Routes.CHAT_FRIEND_DETAIL,
      page: () => const ChatFriendDetailPage(),
      binding: ChatFriendDetailBinding(),
    ),
    GetPage(
      name: Routes.CHAT_GROUP_DETAIL,
      page: () => const ChatGroupDetailPage(),
      binding: ChatGroupDetailBinding(),
    ),
    GetPage(
      name: Routes.FORWARD_MESSAGE,
      page: () => const ForwardMessagePage(),
      binding: ForwardMessageBinding(),
    ),
    GetPage(
      name: Routes.EDIT_GROUP_NAME,
      page: () => const EditGroupNamePage(),
      binding: EditGroupNameBinding(),
    ),
    GetPage(
      name: Routes.GROUP_ADD,
      page: () => const GroupAddPage(),
      binding: GroupAddBinding(),
    ),
    GetPage(
      name: Routes.GROUP_REDUCE,
      page: () => const GroupReducePage(),
      binding: GroupReduceBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PWD,
      page: () => PwdEditPage(),
      binding: PwdEditBinding(),
    ),
    GetPage(
      name: Routes.NICK_NAME_EDIT,
      page: () => const NickNameEditPage(),
      binding: NickNameEditBindings(),
    ),
    GetPage(
      name: Routes.EDIT_CHATNO,
      page: () => ChatNoEditPage(),
      binding: ChatNoEditBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PHONE,
      page: () => PhoneEditPage(),
      binding: PhoneEditBinding(),
    ),
    GetPage(
      name: Routes.EDIT_ADDR,
      page: () => AddrEditPage(),
      binding: AddrEditBinding(),
    ),
  ];



}
