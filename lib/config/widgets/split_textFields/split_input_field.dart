import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/provider/bet_split_provider.dart';
import 'package:flutter_bet_track/config/theme/app_theme.dart';
import 'package:flutter_bet_track/config/widgets/const/container_shadow.dart';
import 'package:provider/provider.dart';

class SplitInputField extends StatefulWidget {
  final TextEditingController textController;
  final TextInputType inputType;
  final bool isAutoFocus;
  final String labelText;
  final Function onEdit;
  final FormFieldValidator splitFormValidate;

  SplitInputField({this.textController,
    this.inputType,
    this.isAutoFocus,
    this.onEdit, this.labelText, this.splitFormValidate,});

  @override
  _SplitInputFieldState createState() => _SplitInputFieldState();
}

class _SplitInputFieldState extends State<SplitInputField> {
  //final GlobalKey<FormState> splitFormId = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final splitProvider = Provider.of<BetSplitProvider>(context);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        //borderRadius: BorderRadius.circular(8),
        //boxShadow: containerShadow,
      ),
      child: TextFormField(
        controller: widget.textController,
        keyboardType: widget.inputType,
        validator: widget.splitFormValidate,
        //textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: Colors.black.withOpacity(0.7),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        //onChanged: betProvider.betTextChanges,
        //onChanged: widget.onEdit,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          //border: InputBorder.none,
          hintText: widget.labelText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
