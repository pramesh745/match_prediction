import 'package:flutter/material.dart';
import 'package:match_prediction_app/screens/auth/register_page.dart';
import 'package:match_prediction_app/screens/user_screens/user_homepage.dart';
import 'package:match_prediction_app/services/auth_provider.dart';
import 'package:match_prediction_app/utils/token_storage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    // TODO: implement initState
    checkLoggedIn();
    super.initState();
  }

  Future<void> checkLoggedIn() async {
    final success = await TokenStorage.isLoggedIn();
    if (success) {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (_) => UserHomepage()), (route)=> false);
    }
  }


  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

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
                      builder: (context, loginProvider, child) =>
                      loginProvider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Welcome Back",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Login to your account",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 30),

                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email cannot be Empty";
                                } else if (!value.contains("@gmail.com")) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: const Icon(Icons.email_outlined),
                                filled: true,
                                fillColor: const Color(0xFFF1F3F6),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password cannot be Empty";
                                }
                                return null;
                              },
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: const Icon(Icons.lock_outline),
                                filled: true,
                                fillColor: const Color(0xFFF1F3F6),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            const SizedBox(height: 25),

                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 5,
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final successLogin =
                                    await loginProvider.postLogin(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    );

                                    if (successLogin) {
                                      ScaffoldMessenger
                                          .of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Successfully Logged In"),
                                        ),
                                      );

                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => UserHomepage(),
                                        ),
                                            (route) => false,
                                      );
                                    } else {
                                      ScaffoldMessenger
                                          .of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text("Failed to Login"),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => RegisterPage(),
                                      ),
                                          (route) => false,
                                    );
                                  },
                                  child: Text(
                                    "Register",
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