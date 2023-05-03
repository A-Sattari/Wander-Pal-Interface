
import "gathering_card.dart";
import "package:flutter/material.dart";

class GatheringsHighlightList extends StatefulWidget {
  const GatheringsHighlightList({super.key});

  @override
  State<GatheringsHighlightList> createState() => _GatheringsHighlightListState();
}

class _GatheringsHighlightListState extends State<GatheringsHighlightList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: ExpansionTile(
        maintainState: true,
        initiallyExpanded: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Happening Today",
              textAlign: TextAlign.left,
            ),
            Text(
              "2020-4-11",
              textAlign: TextAlign.right,
            ),
          ],
        ),
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                GatheringCard(
                  "Title",
                  "Description",
                  DateTime(2023, 1, 12, 10, 30),
                ),
                GatheringCard(
                  "Title",
                  "Description",
                  DateTime(2023, 1, 12, 10, 30),
                  endDateTime: DateTime(2023, 2, 12, 15, 30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}