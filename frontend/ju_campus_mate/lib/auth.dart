// Temporary in-memory user DB (simulating admin-inserted users)

String? loggedInEmail;
String? loggedInName;

List<Map<String, String>> registeredUsers = [
  {
    "name": "Lakshya Mittal",
    "email": "lakshyamittal23503@gmail.com",
    "password": "23503"
  },
  {
    "name": "Palak Gupta",
    "email": "palak7304.gupta@gmail.com",
    "password": "7304"
  },
  {
    "name": "Kinjal Mehrotra",
    "email": "kinjalmehrotra123@gmail.com",
    "password": "123"
  },
  {
    "name": "Admin",
    "email": "admin@ju.in",
    "password": "admin123"
  }
];

// NOTE: No register logic here.
// Users must already exist in this list.
