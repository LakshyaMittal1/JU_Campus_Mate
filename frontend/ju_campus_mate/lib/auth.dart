// Temporary in-memory user DB (simulating admin-inserted users)

String? loggedInEmail;
String? loggedInName;

List<Map<String, String>> registeredUsers = [
  {
    "name": "Lakshya Mittal",
    "email": "lakshya.22bcon168@jecrcu.edu.in",
    "password": "lakshya_168"
  },
  {
    "name": "Admin",
    "email": "admin@ju.in",
    "password": "admin123"
  }
];

// NOTE: No register logic here.
// Users must already exist in this list.
