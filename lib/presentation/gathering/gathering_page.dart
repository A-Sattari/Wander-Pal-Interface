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
      children: <Widget>[GatheringsHighlightList()],
    );
  }
}