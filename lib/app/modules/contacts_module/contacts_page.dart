import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'contacts_controller.dart';


class ContactsPage extends GetView<ContactsController> {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('通讯录'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // Handle add contact action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: '搜索',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onChanged: (value) => controller.filterContacts(value),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = controller.filteredContacts[index];
                return Dismissible(
                  key: Key(contact),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    controller.deleteContact(contact);
                    Get.snackbar('删除', '$contact 已删除');
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                    ),
                    title: Text(contact),
                    onTap: () {
                      // Handle contact tap
                    },
                  ),
                );
              },
            )),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '消息',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: '通讯录',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: '邀请',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.purple,
        onTap: (index) {
          // Handle bottom navigation tap
        },
      ),
    );
  }
}
