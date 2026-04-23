import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_prediction_app/services/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../core/models/get_auth_me.dart';
import '../../services/branch_provider.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? selectedValue;
  Branch? selectedBranch;
  final List<String> branches = [];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<BranchProvider>(context, listen: false).getBranches();
    });
  }

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
              child: SingleChildScrollView(
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
                      onPressed: () async {
                        _showCreateUserDialog(context, inputStyle);
                      },
                      icon: const Icon(Icons.account_tree),
                      label: const Text("Create User"),
                      style: buttonStyle,
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: 400,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Available Users",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 12),

                          const Divider(),

                          const SizedBox(height: 8),

                          // // Placeholder content
                          // Consumer<BranchProvider>(
                          //   builder: (context, branchProvider, child) {
                          //     if (branchProvider.isLoading) {
                          //       return Center(
                          //         child: const CircularProgressIndicator(),
                          //       );
                          //     }
                          //     if (branchProvider.branchLists.isEmpty) {
                          //       return const Center(
                          //         child: Text("No Users Available"),
                          //       );
                          //     }
                          //     return Expanded(
                          //       child: Center(
                          //         child: RefreshIndicator(
                          //           onRefresh: branchProvider.getBranches,
                          //           child: Container(
                          //             width: double.infinity,
                          //             padding: const EdgeInsets.all(16),
                          //             decoration: BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: BorderRadius.circular(16),
                          //               border: Border.all(
                          //                 color: Colors.grey.shade200,
                          //               ),
                          //             ),
                          // child: ListView.builder(
                          //   itemCount:
                          //       branchProvider.branchLists.length,
                          //   itemBuilder: (context, index) {
                          //     final branch =
                          //         branchProvider.branchLists[index];
                          //     return Container(
                          //       margin: const EdgeInsets.only(
                          //         bottom: 10,
                          //       ),
                          //       child: ElevatedButton(
                          //         onPressed: () {},
                          //         child: Align(
                          //           alignment: Alignment.center,
                          //           child: Text(branch.name ?? ""),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                          // ),
                          // ),
                          // ),
                          // );
                          // },
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.home), Text("Back to Home")],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // / ------------------ DIALOGS ------------------
  void _showCreateUserDialog(BuildContext context, InputDecoration inputStyle) {
    showDialog(
      context: context,
      builder: (_) => Consumer<AuthProvider>(
        builder: (context, authProvider, child) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Create User"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name cannot be Empty";
                    }
                  },
                  controller: _displayNameController,
                  decoration: inputStyle.copyWith(hintText: "Display name"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email cannot be Empty";
                    }
                    if (!value.contains("@gmail.com")) {
                      return "Please enter valid Email";
                    }
                  },
                  controller: _emailController,
                  decoration: inputStyle.copyWith(hintText: "Email"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be Empty";
                    }
                  },
                  controller: _passwordController,
                  obscureText: true,
                  decoration: inputStyle.copyWith(hintText: "Password"),
                ),
                SizedBox(height: 12),
                StatefulBuilder(
                  builder: (context, setStateDialog) {
                    return Consumer<BranchProvider>(
                      builder: (context, branchProvider, child) {
                        return DropdownButton<String>(
                          hint: const Text("Select Branch"),
                          value: selectedValue,
                          isExpanded: true,
                          items: branchProvider.branchLists
                              .map<DropdownMenuItem<String>>((branch) {
                                return DropdownMenuItem<String>(
                                  value: branch.name ?? "",
                                  child: Text(branch.name ?? ""),
                                );
                              })
                              .toList(),
                          onChanged: (value) {
                            setStateDialog(() {
                              selectedValue = value;
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: authProvider.isLoading
                  ? null
                  : () async {
                if (_formKey.currentState!.validate()) {

                  final createUser = await authProvider.postUser(
                    displayName: _displayNameController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );

                  if (createUser) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("User Created Successfully")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to Create User")),
                    );
                  }
                }
              },
              child: authProvider.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
