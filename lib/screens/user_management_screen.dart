import 'package:flutter/material.dart';
import '../services/api_service.dart';

class UserManagementScreen extends StatefulWidget {
  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List users = [];
  final emailController = TextEditingController();
  String role = 'viewer';

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    final data = await ApiService.getUsers();
    setState(() => users = data);
  }

  void addUser() async {
    await ApiService.addUser({'email': emailController.text, 'role': role});
    emailController.clear();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Management")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            DropdownButton(
              value: role,
              items: ['admin', 'viewer'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
              onChanged: (val) => setState(() => role = val!),
            ),
            ElevatedButton(onPressed: addUser, child: Text("Add User")),
            Divider(),
            Expanded(
              child: ListView(
                children: users.map<Widget>((u) => ListTile(
                  title: Text(u['email']),
                  subtitle: Text(u['role']),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
