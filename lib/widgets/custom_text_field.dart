import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';

typedef OnSavedCallback = void Function(String? text);
typedef ValidatorCallback = String? Function(String? text);

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.label,
    this.hint,
    this.suffixIcon,
    this.showValidCheck = false,
    this.isLast = false,
    this.maxCount = 100, // default to 100 blindly
    this.keyboardType = TextInputType.text,
    this.onEditingComplete,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    required this.maxlines,
    this.containerHeight,
    this.isPassword = false,
    this.enabled = true,
    required this.textEditingController,
  }) : super(key: key);
  final String? label;
  final bool? enabled;
  final String? hint;
  final String? suffixIcon;
  final bool? showValidCheck; // just to show checkmark
  final double? containerHeight;
  final bool isLast;
  final bool? isPassword;
  final int maxCount;
  final int maxlines;
  final TextInputType? keyboardType;
  final VoidCallback? onEditingComplete;
  final OnSavedCallback? onSaved;
  final ValidatorCallback? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController textEditingController;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool valid = false;

  @override
  Widget build(BuildContext context) {
    // debugPrint("prefix =  ${widget.prefixIcon}");
    // debugPrint("prefix length =  ${widget.prefixIcon?.length}");
    // debugPrint("prefix isempty =  ${widget.prefixIcon?.isEmpty}");
    return Container(
      height: widget.containerHeight ?? 48,
      decoration: BoxDecoration(
        color: ColorConstants.appWhite,
        border: Border.all(width: 1.0, color: ColorConstants.appGreen),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 0.5,
            color: ColorConstants.appGreen,
          )
        ],
      ),
      child: TextFormField(
        //focusNode: AlwaysDisabledFocusNode(),
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxlines,
        controller: widget.textEditingController,
        onChanged: (String text) {
          if (widget.keyboardType == TextInputType.multiline) {
            setState(() {
              widget.textEditingController.text;
            });
          }
        },

        onEditingComplete: widget.onEditingComplete,
        onSaved: widget.onSaved,
        obscureText: widget.isPassword ?? false,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6.0, horizontal: 18.0),
          // counterText: (widget.keyboardType == TextInputType.multiline
          //     ? '${textController.text.length}/${widget.maxCount}'
          //     : null),
          // counterStyle: widget.keyboardType == TextInputType.multiline
          //     ? FontType.normal.style(size: 14.0, color: ColorConstants.appGrey)
          //     : null,
          isDense: false,

          suffixIcon: (() {
            if (widget.suffixIcon == null) {
              return null;
            }
            return Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Image.asset(
                  widget.suffixIcon ?? "",
                  color: ColorConstants.appGreen,
                ));
          }()),
          border: InputBorder.none,
          hintText: widget.hint ?? "Hint",
          hintStyle: FontType.normal.style(
            size: 18.0,
            color: Colors.black.withOpacity(0.52),
            appFontFamilyName: 'Poppins',
            shadows: [
              Shadow(
                blurRadius: 0.5,
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0.3, 0.3),
              ),
            ],
          ),
        ),
        inputFormatters: widget.inputFormatters,
        textInputAction:
            (widget.isLast) ? TextInputAction.done : TextInputAction.next,
        style: FontType.normal.style(
          size: 18.0,
          color: Colors.black.withOpacity(0.80),
          appFontFamilyName: 'Poppins',
          shadows: [
            Shadow(
              blurRadius: 0.4,
              color: Colors.black.withOpacity(0.20),
              offset: Offset(0.2, 0.2),
            ),
          ],
        ),
        validator: (value) {
          if (widget.showValidCheck ?? false) {
            setState(() {
              valid = (value == null || value.isEmpty) ? false : true;
            });
          }
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          return null;
        },
      ),
    );
  }
}
