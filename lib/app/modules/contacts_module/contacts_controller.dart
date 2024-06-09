import 'package:get/get.dart';

class ContactsController extends GetxController{
  var contacts = <String>[].obs;
  var filteredContacts = <String>[].obs;
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    contacts.addAll([
      "上官婉儿", "王昭君", "杨玉环", "西施", "李清照", "蔡文姬",
      "卓文君", "唐伯虎", "祝枝山", "文征明", "徐祯卿",      "上官婉儿", "王昭君", "杨玉环", "西施", "李清照", "蔡文姬",
      "卓文君", "唐伯虎", "祝枝山", "文征明", "徐祯卿",      "上官婉儿", "王昭君", "杨玉环", "西施", "李清照", "蔡文姬",
      "卓文君", "唐伯虎", "祝枝山", "文征明", "徐祯卿",      "上官婉儿", "王昭君", "杨玉环", "西施", "李清照", "蔡文姬",
      "卓文君", "唐伯虎", "祝枝山", "文征明", "徐祯卿",      "上官婉儿", "王昭君", "杨玉环", "西施", "李清照","李思思", "蔡文姬",
      "卓文君", "唐伯虎", "祝枝山", "文征明", "徐祯卿"
    ]);
    filteredContacts.assignAll(contacts);
  }

  void filterContacts(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      filteredContacts.assignAll(contacts);
    } else {
      filteredContacts.assignAll(
          contacts.where((contact) => contact.contains(query)).toList()
      );
    }
  }

  void deleteContact(String contact) {
    contacts.remove(contact);
    filterContacts(searchText.value);  // Ensure the filtered list is updated
  }
}
