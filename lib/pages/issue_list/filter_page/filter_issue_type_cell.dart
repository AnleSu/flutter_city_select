import 'dart:ffi';

import 'package:flutter/material.dart';
import 'filter_model.dart';

typedef void FilterIssueTypeCellClick(var model);

class FilterIssueTypeCell extends StatefulWidget {
  final TaskTypeItemModel model;
  final TaskSourceItemModel sourceItemModel;
  bool isSelected;
  FilterIssueTypeCellClick cellClick;
  FilterIssueTypeCell({this.model, this.sourceItemModel, this.isSelected = false, this.cellClick});

  @override
  _FilterIssueTypeCellState createState() => _FilterIssueTypeCellState();
}

class _FilterIssueTypeCellState extends State<FilterIssueTypeCell> {


  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color(0xFFDCDFE6),width: 0.5),
        color: widget.isSelected
            ? Color(0xFFFEAB00).withOpacity(0.1)
            : Colors.white,
      ),
      child: InkWell(
        onTap: () {
          widget.cellClick(widget.model ?? widget.sourceItemModel);
          setState(() {

          });
        },
        child: Text(

          widget.model != null ? widget.model.typeString : widget.sourceItemModel.typeString,
          textAlign: TextAlign.center,
          style: TextStyle(

            fontSize: 14,
            color: widget.isSelected ? Color(0xFFFEAB00) : Color(0xFF333333),
          ),
        ),
      ),
    );
  }
}
