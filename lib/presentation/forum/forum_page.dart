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

class _ForumPageState extends ConsumerState<ForumPage>
    with TickerProviderStateMixin {

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
          "Here is the content" * index)),
    );

    return SingleChildScrollView(
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
            onPressed: () {
              _createCityFilterWidget();
            },
            label: const Text("City"),
            icon: const Icon(Icons.arrow_drop_down),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 30),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              _createSortPopupWidget();
            },
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

  //TODO: Fix: Selection state does not change unless search is selected
  //TODO: In scroll, the green background is shown underneath the search bar
  Future _createCityFilterWidget() {
    List<String> items = List.generate(15, (index) => "City ${index + 1}");
    List<String> selectedItems = [];
    void toggleSelection(String item) {
      setState(() {
        if (selectedItems.contains(item)) {
          selectedItems.remove(item);
        } else {
          selectedItems.add(item);
        }
      });
    }

    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(25.0)),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                    ),
                  ),
                ),
                Expanded(
                  // Use ListView.separated instead of ListView.builder
                  child: ListView.separated(
                    itemCount: items.length,
                    // Use separatorBuilder to create a Divider widget between each item
                    separatorBuilder: (context, index) => const Divider(),

                    itemBuilder: (context, index) {
                      String item = items[index];
                      return GestureDetector(
                        onTap: () {
                          toggleSelection(item);
                        },
                        child: ListTile(
                          title: Text(item),
                          // Set the selected property to true if the item is in the selected list
                          selected: selectedItems.contains(item),
                          // Set the selected tile color to green
                          selectedTileColor: Colors.green,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _createSortPopupWidget() {
    const List<String> list = <String>["One", "Two", "Three", "Four"];

    return showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(250, 120, 100, 100),
      items: list.map((String item) {
        return PopupMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
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
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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