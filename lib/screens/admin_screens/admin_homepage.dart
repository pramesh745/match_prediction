import 'package:flutter/material.dart';
import 'package:match_prediction_app/screens/admin_screens/all_branches.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
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
                    "Browse your data",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 40),

                  // Show Branches
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AllBranches(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.account_tree),
                    label: const Text("Show Branches"),
                    style: buttonStyle,
                  ),

                  const SizedBox(height: 16),

                  // Show Users
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const UserListPage(),
                      //   ),
                      // );
                    },
                    icon: const Icon(Icons.people),
                    label: const Text("Show Users"),
                    style: buttonStyle,
                  ),

                  const SizedBox(height: 16),

                  // Show Matches
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const MatchListPage(),
                      //   ),
                      // );
                    },
                    icon: const Icon(Icons.sports_soccer),
                    label: const Text("Show Matches"),
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
}