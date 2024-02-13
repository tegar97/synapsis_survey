import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:synapsis_survey/common/theme.dart';

import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  CustomFormField({
    Key? key,
    required this.hintText,
    this.inputFormatters,
    this.validator,
    required this.state,
    required this.labelText,
    this.maxLines = 1,
    this.isSecure = false,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  final int maxLines;
  final String hintText;
  final String labelText;
  final TextEditingController state;
  final bool isSecure;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputType? inputType;

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText , style: bodyTextStyle),
        SizedBox(height: 4),
        TextFormField(
          style: TextStyle(fontSize: 15),
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          controller: widget.state,
          maxLines: widget.maxLines,
          keyboardType: widget.inputType,
          obscureText: _isObscured && widget.isSecure,
          decoration: InputDecoration(
            fillColor: Color(0xffFBFBFB),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
              borderSide: BorderSide(color: secondaryColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
              borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1),
              borderSide: BorderSide(color: Color(0xffEDEDED), width: 1.5),
            ),
            labelStyle: TextStyle(color: Colors.black),
            hintText: widget.hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            suffixIcon: widget.isSecure
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: _isObscured ? Colors.grey : primaryColor,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
