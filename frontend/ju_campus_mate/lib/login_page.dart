/* import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage = "";

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Search in registered user list
    final user = registeredUsers.firstWhere(
      (u) => u["email"] == email && u["password"] == password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      loggedInEmail = user["email"];
      loggedInName = user["name"];

      Navigator.pushReplacementNamed(context, '/chat');
    } else {
      setState(() {
        errorMessage = "Invalid email or password!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFADAD),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 330,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(label: Text("Email")),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(label: Text("Password")),
              ),

              const SizedBox(height: 20),

              if (errorMessage.isNotEmpty)
                Text(errorMessage, style: const TextStyle(color: Colors.red)),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: login,
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */



/*
import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  void login() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final pass = passController.text.trim();

    // Verify against temporary frontend "database"
    final user = registeredUsers.firstWhere(
      (u) =>
          u['name'] == name &&
          u['email'] == email &&
          u['password'] == pass,
      orElse: () => {},
    );

    if (user.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid credentials")),
      );
      return;
    }

    // Store logged-in info
    loggedInName = name;
    loggedInEmail = email;

    Navigator.pushReplacementNamed(context, '/chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: login,
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
*/

/*

import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage = "";

  void login() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Search in registered user list
    final user = registeredUsers.firstWhere(
      (u) =>
          u["name"] == name &&
          u["email"] == email &&
          u["password"] == password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      loggedInName = user["name"];
      loggedInEmail = user["email"];

      Navigator.pushReplacementNamed(context, '/chat');
    } else {
      setState(() {
        errorMessage = "Invalid name, email, or password!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFADAD),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 330,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // NAME Field
              TextField(
                controller: nameController,
                decoration: const InputDecoration(label: Text("Name")),
              ),
              const SizedBox(height: 10),

              // EMAIL Field
              TextField(
                controller: emailController,
                decoration: const InputDecoration(label: Text("Email")),
              ),
              const SizedBox(height: 10),

              // PASSWORD Field
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(label: Text("Password")),
              ),

              const SizedBox(height: 20),

              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: login,
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

*/



import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage = "";

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Search in registered user list
    final user = registeredUsers.firstWhere(
      (u) =>
          u["email"] == email &&
          u["password"] == password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      loggedInName = user["name"];      // Still available from saved user
      loggedInEmail = user["email"];

      Navigator.pushReplacementNamed(context, '/chat');
    } else {
      setState(() {
        errorMessage = "Invalid email or password!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFADAD),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 330,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // EMAIL Field
              TextField(
                controller: emailController,
                decoration: const InputDecoration(label: Text("Email")),
              ),
              const SizedBox(height: 10),

              // PASSWORD Field
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(label: Text("Password")),
              ),
              const SizedBox(height: 20),

              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: login,
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

