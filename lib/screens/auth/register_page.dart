import 'package:flutter/material.dart';
import 'package:match_prediction_app/core/api_const.dart';
import 'package:match_prediction_app/screens/auth/login_page.dart';
import 'package:match_prediction_app/services/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Center(
                  child: Container(
                    width: constraints.maxWidth > 600 ? 420 : double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0.08),
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Consumer<AuthProvider>(
                      builder: (context, registerProvider, child) =>
                          registerProvider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),

                                  /// Title
                                  const Text(
                                    "Create Account",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  const Text(
                                    "Sign up to get started",
                                    style: TextStyle(color: Colors.grey),
                                  ),

                                  const SizedBox(height: 30),

                                  /// Name
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Display Name cannot be empty";
                                      }
                                    },
                                    controller: _displayNameController,
                                    decoration: InputDecoration(
                                      hintText: "Display Name",
                                      prefixIcon: const Icon(Icons.person),
                                      filled: true,
                                      fillColor: const Color(0xFFF1F3F6),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  /// Email
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty) {
                                        return "Email cannot be Empty";
                                      }else if(!value.contains("@gmail.com")){
                                        return "Please enter valid Email";
                                      }
                                    },
                                    controller: _emailController,

                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFF1F3F6),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  /// Password
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Password cannot be Empty";
                                      }
                                    },
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFF1F3F6),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 30),

                                  /// Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepPurple,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        elevation: 5,
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          final registered =
                                              await registerProvider
                                                  .postRegister(
                                                    displayName:
                                                        _displayNameController
                                                            .text
                                                            .trim(),
                                                    email: _emailController.text
                                                        .trim(),
                                                    password:
                                                        _passwordController.text
                                                            .trim(),
                                                  );
                                          if (registered) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Successfully Registered",
                                                ),
                                              ),
                                            );
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => LoginPage(),
                                              ),
                                              (route) => false,
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Failed to Register",
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: const Text(
                                        "Register",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  /// Footer
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Already have an account? "),
                                      GestureDetector(onTap: (){
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => LoginPage(),
                                          ),
                                              (route) => false,
                                        );
                                      },
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
