import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:wander_pal/services/account_service.dart";

class LoginPage extends ConsumerWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountService = ref.read(accountServiceProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              final credential = await accountService.signInWithGoogle();
              await accountService.setupAccount(credential);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              minimumSize: const Size(240, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text("Google"),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final credential = await accountService.signInWithFacebook();
              await accountService.setupAccount(credential);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF1877F2),
              minimumSize: const Size(240, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text("Facebook"),
          ),
        ],
      ),
    );
  }
}