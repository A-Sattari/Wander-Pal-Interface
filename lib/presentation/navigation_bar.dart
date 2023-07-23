import "package:flutter/material.dart";
import "package:wander_pal/models/discussion.dart";
import "package:wander_pal/models/discussion_category.dart";
import "package:wander_pal/presentation/forum/discussion_card.dart";
import "package:wander_pal/presentation/gathering/gathering_page.dart";
import "package:wander_pal/presentation/authentication/login_page.dart";

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.event),
            label: "Gathering",
          ),
          NavigationDestination(
            icon: Icon(Icons.forum),
            label: "Forum",
          ),
        ],
      ),
      body: <Widget>[
        const LoginPage(),
        const GatheringPage(),
        Container(
          alignment: Alignment.center,
          child: DiscussionCard(Discussion(1, 110, DiscussionCategory(1, "Question"), "IRI", "Bandar Abbas", "How do you guys survive there with such humidity? 🥸")),
        ),
      ][currentPageIndex],
    );
  }
}