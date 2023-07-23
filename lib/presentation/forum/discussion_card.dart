import "package:intl/intl.dart";
import "package:flutter/material.dart";
import "package:wander_pal/models/discussion.dart";

class DiscussionCard extends StatefulWidget {
  final Discussion _discussion;

  const DiscussionCard(this._discussion, {super.key});

  @override
  State<DiscussionCard> createState() => _DiscussionCardState();
}

class _DiscussionCardState extends State<DiscussionCard> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 1,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3.0),
                      child: Image.network(
                        "https://cdn.britannica.com/73/2573-004-29818847/Flag-Mexico.jpg",
                        width: 30,
                        height: 20,
                        fit: BoxFit.fill
                      ),
                    ),
                    Text(" ${widget._discussion.city}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ]),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 151, 231, 156),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(widget._discussion.category.name, style: const TextStyle(color: Colors.black)),
                  ),
                ],
              ),
              // Middle section
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 10),
                child: Container(
                    margin: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                    child: Text(widget._discussion.content, maxLines: 3, overflow: TextOverflow.ellipsis)
                  ),
              ),
              // Bottom section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage:
                            NetworkImage("https://picsum.photos/205"),
                      ),
                      Text(" " "User's name"),
                    ],
                  ),
                  const Row(
                    children: [
                      Text("3"),
                      Icon(Icons.mode_comment_outlined),
                    ],
                  ),
                  Text(DateFormat("yyyy-MM-dd").format(widget._discussion.creationDate)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}