import "firebase_options.dart";
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:wander_pal/presentation/navigation_bar.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: WanderPalApp()));
}

class WanderPalApp extends StatelessWidget {
  const WanderPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wander Pal",
      theme: ThemeData(useMaterial3: true),
      home: const MainNavigationBar()
    );
  }
}