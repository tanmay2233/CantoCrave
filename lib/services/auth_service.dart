// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final GoogleSignIn googleSignIn = GoogleSignIn();

//   Future<User?> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;

//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );

//         final UserCredential userCredential =
//             await FirebaseAuth.instance.signInWithCredential(credential);
//         return userCredential.user;
//       } else {
//         // Handle sign-in cancellation
//         return null;
//       }
//     } catch (e) {
//       print("Error signing in with Google: $e");
//       // Handle sign-in error
//       return null;
//     }
//   }

//   Future<bool> signOutFromGoogle() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       await googleSignIn.signOut(); // Also sign out from Google
//       return true;
//     } catch (e) {
//       print("Error signing out from Google: $e");
//       return false;
//     }
//   }
// }
