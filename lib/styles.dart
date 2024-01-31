import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

List<DropdownMenuItem> gender = [
  DropdownMenuItem(
    value: "Please Select",
    child: Text(
      "Please Select",
      style: subTitleTextWithBold(),
    ),
  ),
  DropdownMenuItem(
    value: "Male",
    child: Text(
      "Male",
      style: subTitleTextWithBold(),
    ),
  ),
  DropdownMenuItem(
    value: "Female",
    child: Text(
      "Female",
      style: subTitleTextWithBold(),
    ),
  ),
  DropdownMenuItem(
    value: "Prefer not to say",
    child: Text(
      "Prefer not to say",
      style: subTitleTextWithBold(),
    ),
  ),
];
List<DropdownMenuItem> gender2 = [
  DropdownMenuItem(
    value: "Please Select",
    child: Text(
      "Please Select",
      style: subTitleTextWithBold(),
    ),
  ),
  DropdownMenuItem(
    value: "Male",
    child: Text(
      "Male",
      style: subTitleTextWithBold(),
    ),
  ),
  DropdownMenuItem(
    value: "Female",
    child: Text(
      "Female",
      style: subTitleTextWithBold(),
    ),
  ),
];

TextStyle subTitleTextWithBold() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(fontSize: 14.0, color: blackColor, fontWeight: FontWeight.w600),
  );
}

Center getDropDownTextField(Function(dynamic) param0, {hint = "", double leftPadding = 0.0, double rightPadding = 0.0, Null Function()? onpress, int selection = 0}) {
  return Center(
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border:  Border.all(
        color: pinkColor, // You can set the color of the stroke here
        width: 1.0, // You can set the width of the stroke here
      ),),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: DropdownButtonFormField(
          iconDisabledColor: Colors.black,
            iconEnabledColor: blackColor,
            icon: Icon(CupertinoIcons.arrow_down,color: pinkColor,size: 16,),
            isExpanded: true,
            value: gender[selection].value,
            items: gender,
            decoration: dropDownLabelDecorationStyle(hintValue: ""),
            onChanged: param0),
      ),
    ),
  );
}
Center getDropDownTextField2(Function(dynamic) param0, {hint = "", double leftPadding = 0.0, double rightPadding = 0.0, Null Function()? onpress, int selection = 0}) {
  return Center(
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border:  Border.all(
        color: pinkColor, // You can set the color of the stroke here
        width: 1.0, // You can set the width of the stroke here
      ),),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: DropdownButtonFormField(
            icon: Icon(CupertinoIcons.arrow_down,color: pinkColor,size: 16,),
            isExpanded: true,
            value: gender2[selection].value,
            items: gender2,
            decoration: dropDownLabelDecorationStyle(hintValue: ""),
            onChanged: param0),
      ),
    ),
  );
}
SizedBox getVerticalField(
    {String textFieldName = "",
      editTextHint = "",
      TextInputType inputField = TextInputType.name,
      required Null Function(String) onChanged,
      on,
      required Null Function() onTap,
      bool? isEnabled,
      TextEditingController? controller,
      TextInputAction? textInputAction = TextInputAction.next,
      double rightPadding = 0.0,int maxlength =150}) {
  return SizedBox(
    height: 50,
    child: GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: rightPadding),
        child: getEditTextField(
            textInputAction: textInputAction,
            controller: controller,
            isEnabled: isEnabled,
            hint: editTextHint,
            inputField: inputField,
            onChanged: onChanged),
      ),
    ),
  );
}
TextField getEditTextField(
    {String hint = "",
      required TextInputType inputField,
      required Null Function(String) onChanged,
      Null Function()? onTap,
      TextEditingController? controller,
      bool? isEnabled = true,
      FocusNode? focusNode2,
      TextInputAction? textInputAction = TextInputAction.next,
      int? maxLength = 100}) {
  return TextField(
    inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
    focusNode: focusNode2,
    textCapitalization: TextCapitalization.words,
    enableSuggestions: false,
    textInputAction: textInputAction,
    enabled: isEnabled,
    controller: controller,
    onTap: onTap,
    onChanged: onChanged,
    keyboardType: inputField,
    decoration: InputDecoration(
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1, color: pinkColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1, color: Colors.pink),
      ),
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 1, color: pinkColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      hintStyle: ediTextHintStyle(),
      hintText: hint,
    ),
    style: ediTextStyle(),
  );
}
TextStyle ediTextStyle({Color color=blackColor,double fontSize=15.0}) {
  return GoogleFonts.outfit(
    textStyle:  TextStyle(fontWeight: FontWeight.w600, color: color,decoration: TextDecoration.none,fontSize: fontSize),
  );
}
InputDecoration dropDownLabelDecorationStyle({String hintValue = ""}) {
  return InputDecoration(
    fillColor:  Colors.transparent,
    contentPadding: const EdgeInsets.all(10),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 1, color: Colors.transparent),
    ),
    filled: false,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.transparent),
      borderRadius: BorderRadius.circular(10.0),
    ),
    hintStyle: ediTextHintStyle(),
    hintText: hintValue,
  );
}

TextStyle ediTextHintStyle({Color color = editTextHintColor}) {
  return GoogleFonts.outfit(
    textStyle: TextStyle(fontWeight: FontWeight.w300, color: color),
  );
}
