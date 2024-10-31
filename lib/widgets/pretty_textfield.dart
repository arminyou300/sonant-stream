import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PrettyTextField extends StatefulWidget {
  PrettyTextField({
    super.key,
    required this.controller,
    required this.errorText,
    required this.labelText,
    required this.fieldColor,
    required this.borderColor,
    required this.hiddenText,
    required this.isEmail,
    required this.width,
    required this.height,
    required this.maxLength,
    required this.onChanged,
    required this.validate,
  });

  final TextEditingController controller;
  final double width;
  final double height;
  final int maxLength;
  final String errorText;
  final String labelText;
  final Color fieldColor;
  final Color borderColor;
  final bool validate;
  late bool hiddenText;
  final bool isEmail;
  final Function onChanged;

  @override
  State<PrettyTextField> createState() => _PrettyTextFieldState();
}

class _PrettyTextFieldState extends State<PrettyTextField> {
  bool? showPassword;

  @override
  void initState() {
    if (widget.hiddenText) {
      setState(() {
        showPassword = true;
      });
    } else {
      setState(() {
        showPassword = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height + (widget.validate ? 19 : 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: TextField(
            controller: widget.controller,
            textAlign: TextAlign.left,
            maxLength: widget.maxLength,
            onChanged: (value) {
              widget.onChanged(value);
            },
            textInputAction: TextInputAction.next,
            obscureText: showPassword!,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: widget.isEmail
                ? TextInputType.emailAddress
                : TextInputType.name,
            decoration: InputDecoration(
              errorText: widget.validate ? widget.errorText : null,
              errorMaxLines: 1,
              suffixIcon: widget.hiddenText == true
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword!;
                        });
                      },
                      icon: Icon(
                        showPassword == true
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.white38,
                      ),
                    )
                  : null,
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: widget.labelText,
              labelStyle: const TextStyle(
                fontSize: 15,
                color: Colors.white38,
              ),
            ),
            style: TextStyle(
              color: widget.fieldColor,
            ),
            onTapOutside: (event) => FocusScope.of(context).requestFocus(
              FocusNode(),
            ),
          ),
        ),
      ),
    );
  }
}
