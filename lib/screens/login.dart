import 'package:flutter/material.dart';
import './follow_up_home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? selectedMotel;

  final List<String> motels = [
    "Purple Saga",
    "Extended Day",
    "Motel 6",
    "Town Place",
    "Days Inn Snyder",
  ];

  // 🔐 Password Validation
  String? _validatePassword(String password) {
    if (password.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "Password must contain an uppercase letter";
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "Password must contain a lowercase letter";
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return "Password must contain a number";
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      return "Password must contain a special character (!@#\$&*)";
    }
    return null; // valid password
  }

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty || selectedMotel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final passwordError = _validatePassword(password);
    if (passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(passwordError)),
      );
      return;
    }

    // ✅ Login Success (Temporary Navigation)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => FollowUpHomePage(motelName: selectedMotel!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      body: isMobile ? _mobileView() : _webView(),
    );
  }

  // 📱 Mobile View
  Widget _mobileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 80),
          const Icon(Icons.hotel, size: 60, color: Colors.blue),
          const SizedBox(height: 20),
          _textField("Username", _usernameController, Icons.person),
          const SizedBox(height: 12),
          _textField(
            "Password (Min 8 chars, Aa1@)",
            _passwordController,
            Icons.lock,
            obscure: true,
          ),
          const SizedBox(height: 12),
          _motelDropdown(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _login,
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }

  // 💻 Web / Tablet View
  Widget _webView() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.pexels.com/photos/261102/pexels-photo-261102.jpeg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(40),
              alignment: Alignment.bottomLeft,
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.4),
              child: const Text(
                "Snyder Motels\nManagement Portal",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(
            child: Container(
              width: 420,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(blurRadius: 20, color: Colors.black26),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.hotel, size: 60, color: Colors.blue),
                  const SizedBox(height: 20),
                  _textField("Username", _usernameController, Icons.person),
                  const SizedBox(height: 20),
                  _textField(
                    "Password (Min 8 chars, Aa1@)",
                    _passwordController,
                    Icons.lock,
                    obscure: true,
                  ),
                  const SizedBox(height: 20),
                  _motelDropdown(),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 🏨 Motel Dropdown
  Widget _motelDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: selectedMotel,
      hint: const Text("Select Motel"),
      items: motels
          .map((m) => DropdownMenuItem(value: m, child: Text(m)))
          .toList(),
      onChanged: (value) => setState(() => selectedMotel = value),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }

  // ✏ TextField Widget
  Widget _textField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
