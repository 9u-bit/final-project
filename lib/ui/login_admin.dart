import 'package:flutter/material.dart';
import 'package:seseart/ui/logged_in_admin.dart';
import 'package:seseart/ui/signup_admin.dart';
import '/services/api_service.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({super.key});

  @override
  State<LoginAdmin> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginAdmin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E1A47),
        elevation: 0,
        titleSpacing: 24,
        title: const Text(
          'S.ESE.ART Admin',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(500, 50, 500, 50),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF2E1A47).withOpacity(0.05),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),

                // Email field
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Password field
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Login button
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E1A47),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text;

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill in all required fields.',
                            ),
                          ),
                        );
                        return;
                      }

                      try {
                        await ApiService.login(
                          email: email,
                          password: password,
                          role: 'admin',
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoggedInAdmin()),
                        );
                      } catch (e) {
                        final errorMessage = e.toString().replaceFirst(
                          'Exception: ',
                          '',
                        );
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(errorMessage)));
                      }
                    },

                    child: const Text('Login', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 16),

                // Sign-up link
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupAdmin(),
                      ),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Sign-up here!",
                    style: TextStyle(
                      color: Color(0xFF2E1A47),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
