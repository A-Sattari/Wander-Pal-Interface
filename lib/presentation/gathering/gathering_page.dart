import "package:flutter/material.dart";
import "package:wander_pal/presentation/gathering/gatherings_highlight_list.dart";

class GatheringPage extends StatefulWidget {
  const GatheringPage({super.key});

  @override
  State<GatheringPage> createState() => _GatheringPageState();
}

class _GatheringPageState extends State<GatheringPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView(
            children: const [
              Text("Gatherings in ..."),
            ],
          ),
        ),
        // The Bottom Section
        Flexible(
          flex: 8,
          child: Container(
            decoration: _getBottomSectionDesign(),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, right: 10, left: 10),
                  child: GatheringsHighlightList(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 40, right: 10, left: 10),
                  child: GatheringsHighlightList(),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("See more"),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _getBottomSectionDesign() {
    return 
      BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -10),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      );
  }
}