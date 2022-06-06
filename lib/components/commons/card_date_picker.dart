// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:insta_app/components/commons/flat_card.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardDatePicker extends StatefulWidget {
  final DateTime? currentDate;
  final Function(DateTime selectedDate)? onSelected;

  CardDatePicker({
    Key? key,
    this.currentDate,
    this.onSelected,
  }) : super(key: key);

  @override
  _CardDatePickerState createState() => _CardDatePickerState();
}

class _CardDatePickerState extends State<CardDatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.currentDate != null) {
      selectedDate = widget.currentDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatCard(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4.w(context)),
        child: InkWell(
          onTap: () async {
            selectedDate = await showRoundedDatePicker(
              context: context,
              locale: Locale("id", "ID"),
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year - 1),
              lastDate: DateTime(DateTime.now().year + 1),
              borderRadius: 4.w(context),
              height: 45.hp(context),
            );
            widget.onSelected!(selectedDate!);
            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.all(16.w(context)),
            child: Text(
              selectedDate != null
                  ? DateFormat("dd MMMM yyyy", "id").format(selectedDate!)
                  : "pilih tanggal",
              style: Themes(context).black14!.apply(
                    color: selectedDate != null ? Themes.black : Themes.stroke,
                  ),
            ),
          ),
        ),
      ),
      color: Colors.white,
      border: Border.all(color: Themes.stroke),
    );
  }
}
