import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_diario_mobil_1_0_1/config/theme/apptheme.dart';
import 'presentation/provider/connection_provider.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectionProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Registro diario',
            debugShowCheckedModeBanner: false,
            theme: AppTheme().getTheme(),
            initialRoute: '/splash',
            routes: {
              '/splash': (context) => const SplashScreen(),
              '/home': (context) => const HomeScreen(),
              '/login': (context) => const LoginScreen(),
            },
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1)),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
