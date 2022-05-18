import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/providers/auth_provider.dart';
import 'package:weight_tracker_app/providers/weight_provider.dart';
import 'package:weight_tracker_app/screens/authentication/login_screen.dart';
import 'package:weight_tracker_app/screens/authentication/register_screen.dart';
import 'package:weight_tracker_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, WeightDataProvider>(
            create: (BuildContext context) => WeightDataProvider('', []),
            update: (BuildContext context, auth, previous) =>
                WeightDataProvider(auth.token,
                    previous!.dataRecord.isEmpty ? [] : previous.dataRecord)),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {
            '/': (context) =>
                Provider.of<AuthProvider>(context).isUserAuthenticated
                    ? const HomeScreen()
                    : const LoginScreen(),
          }),
    );
  }
}
