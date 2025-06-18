import 'package:flutter/material.dart';
import '/services/api_service.dart';
import 'home.dart';

class SignupAdmin extends StatefulWidget {
  const SignupAdmin({super.key});

  @override
  State<SignupAdmin> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignupAdmin> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool obscureText = false,
    VoidCallback? toggleObscure,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon:
            toggleObscure != null
                ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: toggleObscure,
                )
                : null,
      ),
    );
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
          padding: const EdgeInsets.fromLTRB(300, 50, 300, 50),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
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
                  'Sign Up',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // Two-column layout
                LayoutBuilder(
                  builder: (context, constraints) {
                    // if screen is narrow, fall back to single column
                    bool isWide = constraints.maxWidth > 600;
                    return isWide
                        ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left column
                            Expanded(
                              child: Column(
                                children: [
                                  _buildTextField(_nameController, 'Name'),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    _phoneController,
                                    'Phone Number',
                                    keyboardType: TextInputType.phone,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Right column
                            Expanded(
                              child: Column(
                                children: [
                                  _buildTextField(
                                    _emailController,
                                    'Email',
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(height: 16),
                                  _buildTextField(
                                    _passwordController,
                                    'Password',
                                    obscureText: _obscurePassword,
                                    toggleObscure: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ],
                        )
                        : Column(
                          children: [
                            _buildTextField(_nameController, 'Name'),
                            const SizedBox(height: 16),
                            _buildTextField(
                              _phoneController,
                              'Phone Number',
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              _emailController,
                              'Email',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              _passwordController,
                              'Password',
                              obscureText: _obscurePassword,
                              toggleObscure: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ],
                        );
                  },
                ),

                const SizedBox(height: 24),

                // Sign-up button
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E1A47),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      final name = _nameController.text.trim();
                      final phone = _phoneController.text.trim();
                      final email = _emailController.text.trim();
                      final password = _passwordController.text;

                      // 1. No empty fields
                      if (name.isEmpty ||
                          phone.isEmpty ||
                          email.isEmpty ||
                          password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill in all required fields.',
                            ),
                          ),
                        );
                        return;
                      }

                      // 2. Phone number: digits only
                      if (!RegExp(r'^\d+$').hasMatch(phone)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Phone number must contain digits only.',
                            ),
                          ),
                        );
                        return;
                      }

                      // 3. Email format: must contain @ and a dot suffix
                      if (!RegExp(
                        r'^[\w\.-]+@[\w\.-]+\.\w{2,}$',
                      ).hasMatch(email)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter a valid email address.',
                            ),
                          ),
                        );
                        return;
                      }

                      // 4. Password format: 8-15 chars, upper, lower, number, special char
                      if (!RegExp(
                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~%^()_\-+=]).{8,15}$',
                      ).hasMatch(password)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Password must be 8-15 characters, include uppercase, lowercase, number, and special character.',
                            ),
                          ),
                        );
                        return;
                      }

                      try {
                        final userData = {
                          'name': name,
                          'phone': phone,
                          'email': email,
                          'password': password,
                          'permisos': [],
                          'role': 'admin',
                          'created_at': DateTime.now().toIso8601String(),
                        };

                        final message = await ApiService.register(userData);

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(message)));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Sign-up failed: ${e.toString()}'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16),
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
