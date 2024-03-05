// // Import necessary packages
// import 'package:firebase_auth/firebase_auth.dart';

// // Authentication service
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<User?> signInAnonymously() async {
//     try {
//       UserCredential result = await _auth.signInAnonymously();
//       return result.user;
//     } catch (e) {
//       print('Error signing in anonymously: $e');
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }
