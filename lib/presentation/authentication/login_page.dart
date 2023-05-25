import "package:flutter/material.dart";
import "package:wander_pal/services/account_service.dart";

class LoginPage extends StatelessWidget {

  final AccountService accountService;

  LoginPage({Key? key}) : 
    accountService = AccountService(),
    super(key: key);

  @override
  Widget build(BuildContext context) {
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