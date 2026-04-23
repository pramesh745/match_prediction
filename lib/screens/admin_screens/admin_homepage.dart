import 'package:flutter/material.dart';
import 'package:match_prediction_app/screens/admin_screens/all_branches.dart';
import 'package:match_prediction_app/screens/admin_screens/all_users.dart';
import 'package:match_prediction_app/screens/auth/login_page.dart';
import 'package:match_prediction_app/services/auth_provider.dart';
import 'package:match_prediction_app/services/branch_provider.dart';
import 'package:match_prediction_app/utils/token_storage.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}


class _AdminHomePageState extends State<AdminHomePage> {


  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AuthProvider>(context,listen: false).getAuthMe();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

                  Row(
                    children: [
                      const Text(
                        "Admin Dashboard",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Consumer<BranchProvider>(
                        builder: (context, branchProvider, child) =>
                        branchProvider.isLoading
                            ? CircularProgressIndicator()
                            : IconButton(
                          onPressed: () async {
                            final loggedOut =
                            await TokenStorage.logout();
                            if (loggedOut) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginPage()),
                                    (route) => false,
                              );
                            }
                          },
                          icon: Icon(Icons.logout),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) => Text(
                      "Welcome, ${authProvider.getUserMe?.name}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                  const SizedBox(height: 40),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AllBranches()),
                      );
                    },
                    icon: const Icon(Icons.account_tree),
                    label: const Text("Show Branches"),
                    style: buttonStyle,
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AllUsers(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.people),
                    label: const Text("Show Users"),
                    style: buttonStyle,
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: () {},
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