import "package:intl/intl.dart";
import "package:flutter/material.dart";

class GatheringCard extends StatefulWidget {
  final String _title;
  final String _description;
  final DateTime _startDateTime;
  final DateTime? _endDateTime;

  const GatheringCard(
    this._title, this._description, this._startDateTime,
    {DateTime? endDateTime, super.key}) 
    : _endDateTime = endDateTime;

  @override
  State<GatheringCard> createState() => _GatheringCardState();
}

class _GatheringCardState extends State<GatheringCard> {
  @override
  Widget build(BuildContext context) {
    
    var cardWidgets = <Widget>
    [
      Text(widget._title, textAlign: TextAlign.center),
      ..._getDateInfoWidgets(start: widget._startDateTime, end: widget._endDateTime),
      Text(widget._description)
    ];

    return Card(
      child: SizedBox(
        width: 350,
        height: 150,
        child: Column(children: cardWidgets)),
    );
  }

  List<Widget> _getDateInfoWidgets({required DateTime start, required DateTime? end}) {
    var dateTimeRows = <Widget>[];
    final startContent = StringBuffer(_generateDateTimeText(start));

    if (end != null) {
      // Same End date
      if (start.difference(end).inDays == 0) {
        startContent.write(" - ");
        startContent.write(DateFormat.jm().format(end));
      } else {
        dateTimeRows.add(_generateDateTimeRow(end, Icons.event));
      }
    }
    dateTimeRows.insert(0, _generateDateTimeRow(start, Icons.today));

    return dateTimeRows;
  }

  Row _generateDateTimeRow(DateTime dateTime, IconData icon) {
    return
    Row(children: <Widget>[
      Icon(icon, size: 20),
      Text(_generateDateTimeText(dateTime))
    ]);
  }

  String _generateDateTimeText(DateTime dateTime) {
    return "${DateFormat('yyyy-MM-dd').format(dateTime)} , ${DateFormat.jm().format(dateTime)}";
  }
}