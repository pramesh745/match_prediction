import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_prediction_app/services/branch_provider.dart';
import 'package:provider/provider.dart';

class AllBranches extends StatefulWidget {
  const AllBranches({super.key});

  @override
  State<AllBranches> createState() => _AllBranchesState();
}

class _AllBranchesState extends State<AllBranches> {

  @override
  void initState() {
    // TODO: implement initState
    final provider = Provider.of<BranchProvider>(context, listen:false);
    provider.getBranches();
    super.initState();
  }


  final TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                        _showCreateBranchDialog(context, inputStyle);
                      },
                      icon: const Icon(Icons.account_tree),
                      label: const Text("Create Branch"),
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
                            "Available Branches",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 12),

                          const Divider(),

                          const SizedBox(height: 8),

                          // Placeholder content
                          Consumer<BranchProvider>(
                            builder: (context, branchProvider, child) {
                              if (branchProvider.isLoading) {
                                return Center(
                                  child: const CircularProgressIndicator(),
                                );
                              }
                              if (branchProvider.branchLists.isEmpty) {
                                return const Center(
                                  child: Text("No Branches Available"),
                                );
                              }
                              return Expanded(
                                child: Center(
                                  child: RefreshIndicator(
                                    onRefresh: branchProvider.getBranches,
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                      child:ListView.builder(
                                    itemCount: branchProvider.branchLists.length,
                                      itemBuilder: (context, index) {
                                        final branch = branchProvider.branchLists[index];
                                        return Container(
                                          margin: const EdgeInsets.only(bottom: 10),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(branch.name ?? ""),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
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

  void _showCreateBranchDialog(
    BuildContext context,
    InputDecoration inputStyle,
  ) {
    showDialog(
      context: context,
      builder: (_) => Consumer<BranchProvider>(
        builder: (context, branchProvider, child) => Form(
          key: _formKey,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text("Create Branch"),
            content: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Branch name cannot be empty";
                }
              },
              controller: _nameController,
              decoration: inputStyle.copyWith(hintText: "Branch name"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: branchProvider.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await branchProvider.createBranch(
                            name: _nameController.text.trim(),
                          );

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Branch created successfully"),
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Failed to create Branch"),
                              ),
                            );
                          }
                        }
                      },
                child: branchProvider.isLoading
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
      ),
    );
  }
}
