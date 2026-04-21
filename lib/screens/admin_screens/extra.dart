import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final inputStyle = const InputDecoration(
      filled: true,
      fillColor: Color(0xFFF1F3F6),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide.none,
      ),
    );

    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  const Text(
                    "Admin Dashboard",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Quick actions",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 40),

                  ElevatedButton.icon(
                    onPressed: () {
                      _showCreateBranchDialog(context, inputStyle);
                    },
                    icon: const Icon(Icons.account_tree),
                    label: const Text("Create Branch"),
                    style: buttonStyle,
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: () {
                      _showCreateUserDialog(context, inputStyle);
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text("Create User"),
                    style: buttonStyle,
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: () {
                      _showCreateMatchDialog(context);
                    },
                    icon: const Icon(Icons.sports_soccer),
                    label: const Text("Create Matches"),
                    style: buttonStyle,
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.analytics),
                    label: const Text("LeaderBoard"),
                    style: buttonStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ------------------ DIALOGS ------------------

  void _showCreateBranchDialog(
      BuildContext context, InputDecoration inputStyle) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text("Create Branch"),
        content: TextField(
          decoration: inputStyle.copyWith(hintText: "Branch name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }

  void _showCreateUserDialog(
      BuildContext context, InputDecoration inputStyle) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text("Create User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: inputStyle.copyWith(hintText: "User name"),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: inputStyle.copyWith(hintText: "Password"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }

  void _showCreateMatchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text("Create Match"),
        content: const Text("Match setup UI here"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }
}