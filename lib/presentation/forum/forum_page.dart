import "discussion_card.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "../../models/discussion_category.dart";
import "package:wander_pal/models/discussion.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class ForumPage extends ConsumerStatefulWidget {
  const ForumPage({super.key});

  @override
  ConsumerState createState() => _ForumPageState();
}

class _ForumPageState extends ConsumerState<ForumPage> with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  late TabController _tabController;
  bool _isScrolledDown = false;

  @override
  void initState() {
    super.initState();
    
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        if (_tabController.index != _tabController.previousIndex) {
          _isScrolledDown = false;
        }
      });
    });
    
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          _isScrolledDown = true;
        } else {
          _isScrolledDown = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.14),
        child: Column(
          children: [
            AppBar(
              title: const Text("Forum"),
              toolbarHeight: 35.0,
            ),
            _createFilterBarWidget(),
            _createTabBarWidget()
          ],
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              // Tab 1
              _createTabContentWidget(),
              // Tab 2
              Container(
                alignment: Alignment.center,
                color: Colors.indigo,
                child: const Text("Content"),
              ),
            ],
          ),
          _createAddButton(),
          _createManageButton(),
        ],
      ),
    );
  }

  Widget _createTabContentWidget() {
    List<Widget> discussions = List.generate(
      20,
      (index) => DiscussionCard(Discussion(
        index,
        11,
        DiscussionCategory(index, "Make Connection"),
        "IRI",
        "Ahvaz",
        "Here is the content" * index)
      ),
    );

    return SingleChildScrollView
    (
      controller: _scrollController,
      child: Column(children: discussions),
    );
  }

  Widget _createFilterBarWidget() {
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
        ),
      );
  }

  Widget _createTabBarWidget() {
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

  Widget _createAddButton() {
    return AnimatedPositioned(
      bottom: 15,
      right: _isScrolledDown ? 15 : 60,
      duration: const Duration(milliseconds: 250),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: _isScrolledDown
              ? const EdgeInsets.all(15)
              : const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          ),
          child: Visibility(
            visible: !_isScrolledDown,
            replacement: const Icon(Icons.add, size: 30),
            child: const Row(children: [
              Icon(Icons.add, size: 30),
              SizedBox(width: 10),
              Text("Add"),
            ]),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _createManageButton() {
    return AnimatedPositioned(
      bottom: 15,
      left: _isScrolledDown ? 15 : 60,
      duration: const Duration(milliseconds: 250),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: _isScrolledDown
              ? const EdgeInsets.all(15)
              : const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          ),
          child: Visibility(
            visible: !_isScrolledDown,
            replacement: const Icon(Icons.tune, size: 30),
            child: const Row(children: [
              Icon(Icons.tune, size: 30),
              SizedBox(width: 10),
              Text("Manage"),
            ]),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}