import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'create_group_controller.dart';


class CreateGroupPage extends GetView<CreateGroupController> {

  const CreateGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          // controller: controller,
          decoration: InputDecoration(
            hintText: '搜索',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
          onChanged: _filterContacts,
        ),
        backgroundColor: Colors.green,
        actions: [
          TextButton(
            onPressed: () {
              // Handle done action
            },
            child: Text('完成', style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller.filteredContacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                        controller.filteredContacts[index].avatar),
                  ),
                  title: Text(controller.filteredContacts[index].name),
                  trailing: Icon(Icons.check_circle_outline),
                  onTap: () {
                    // Handle contact selection
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _filterContacts(String query) {
    final filtered = controller.contacts.where((contact) {
      final nameLower = contact.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }
}
