import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FilterIssueTimeCell extends StatefulWidget {
  final String defalutTimeStr;
  final String selectTimeStr;

  FilterIssueTimeCell({this.defalutTimeStr, this.selectTimeStr});

  @override
  _FilterIssueTimeCellState createState() => _FilterIssueTimeCellState();
}

class _FilterIssueTimeCellState extends State<FilterIssueTimeCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: Border.all(color: Color(0xFFDCDFE6), width: 0.5),
      ),
      child: InkWell(
        onTap: () {},
        child: Text(widget.selectTimeStr ?? widget.defalutTimeStr,
          style: TextStyle(
            fontSize: 14,
            color: widget.selectTimeStr != null ? Color(0xFF333333) : Color(0xFFCCCCCC),
          ),
        ),
      ),
    );
  }
}
