import 'package:myapp/about/about.dart';
import 'package:myapp/home/home.dart';
import 'package:myapp/login/login.dart';
import 'package:myapp/profile/profile.dart';
import 'package:myapp/topics/topics.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/about': (context) => const AboutScreen(),
};
