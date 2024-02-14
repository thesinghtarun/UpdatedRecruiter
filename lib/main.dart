import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/firebase_options.dart';
import 'package:recruiter/screens/job_finder_home_screen.dart';
import 'package:recruiter/screens/select_role.dart';
import 'screens/forgot_password/forgotpassword.dart';
import 'screens/phone_auth/otp_screen.dart';
import 'screens/phone_auth/phone_number_scree.dart';
import 'screens/job_provider_home.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    routes: {
      '/': (context) => const Login(),
      '/WelcomeScreen': (context) => const Welcome(),
      '/SignUpScreen': (context) => const SignUp(),
      '/LoginScreen': (context) => const Login(),
      '/SelectRoleScreen': (context) => const SelectRole(),
      '/JobFinderHomeScreen': (context) => const JobFinderHomeScreen(),
      '/JobProviderHomeScreen': (context) => const JobProviderHomeScreen(),
      '/PhoneNumberScreen': (context) => const PhoneNumberScreen(),
      '/OtpScreen': (context) => const OtpScreen(),
      '/ForgetPasswordScreen': (context) => const ForgotPassword(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
