import 'package:flutter/material.dart';

class AdminInvitesScreen extends StatelessWidget {
  const AdminInvitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Invites'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.email),
            title: Text('invitee@example.com'),
            subtitle: Text('Pending'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('user2@example.com'),
            subtitle: Text('Accepted'),
          ),
        ],
      ),
    );
  }
}
