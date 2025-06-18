import 'package:flutter/material.dart';
// import 'package:auto_size_text/auto_size_text.dart'; // flutter pub add auto_size_text
// import 'package:url_launcher/url_launcher.dart'; // flutter pub add url_launcher
// import 'home.dart';
// import 'product.dart';

class LoggedInAdmin extends StatelessWidget {
  const LoggedInAdmin({super.key});

  // NOTE: Will be changed to admin name later
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning, Admin!';
    } else if (hour < 18) {
      return 'Good afternoon, Admin!';
    } else {
      return 'Good evening, Admin!';
    }
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
        actions: [
          _buildMenuItem(context, 'Home', const LoggedInAdmin()), // logged_in_admin.dart
          const SizedBox(width: 24),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getGreeting(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E1A47),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Dashboard Overview',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E1A47),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildStatCard('Total Products', '0', Icons.inventory), // NOTE: Change later
                      _buildStatCard('New Messages', '', Icons.message), // NOTE: Change later
                      _buildStatCard(
                        'Pending Orders',
                        '0',
                        Icons.pending_actions,
                      ), // NOTE: Change later
                    ],
                  ),
                  const SizedBox(height: 44),
                ],
              ),
            ),
            const SizedBox(height: 200),
            // Footer
            Container(
              width: double.infinity,
              color: const Color(0xFF2E1A47),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Meet the Team
                      SizedBox(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Meet the Team',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Sara Alfaro Carrillo',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'GitHub: github.com/salfaroc',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Gwyneth Mendoza Castro',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'GitHub: github.com/9u-bit',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider
                      Container(
                        width: 1,
                        height: 160,
                        color: Colors.white24,
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                      ),
                      // Legal and Technology
                      SizedBox(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Legal & Technology',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              '© 2025 S.ESE.ART — All rights reserved.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Built with:',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '• Python',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '• MongoDB',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '• Flutter',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 300),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: Color(0xFF2E1A47)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
