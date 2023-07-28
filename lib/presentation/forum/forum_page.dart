import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class ForumPage extends ConsumerStatefulWidget {
  const ForumPage({super.key});

  @override
  ConsumerState createState() => _ForumPageState();
}

class _ForumPageState extends ConsumerState<ForumPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // ref.read();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.14
        ),
        child: Column(
          children: [
            AppBar(
              title: const Text("Forum"),
              toolbarHeight: 35.0,
            ),
            _getFilterBarContent(),
            _getTabBarContent()
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:[
          Container(
            color: Colors.blue,
            child: const Text("Content"),
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.indigo,
            child: const Text("Content"),
          )
        ],
      ),
    );
  }

  Widget _getFilterBarContent() {
    return SizedBox(
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            label: const Text("City"),
            icon: const Icon(Icons.arrow_drop_down),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 30),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            label: const Text("Sort: " "Newest"),
            icon: const Icon(Icons.arrow_drop_down),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 30),
            ),
          ),
        ],
      )
    );
  }

  Widget _getTabBarContent() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 40,
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: "Globe"),
              Tab(text: "Canada"),
            ],
            labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height: 40,
            color: const Color.fromARGB(255, 228, 235, 240),
            child: const Icon(Icons.settings),
          ),
          onTap: () {},
        )
      ],
    );
  }
}