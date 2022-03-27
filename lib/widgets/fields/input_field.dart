import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/text_field_provider.dart';

class InputField extends StatelessWidget {
  final Widget? prefix;
  final int? maxLines;
  final bool? enabled;

  final bool? obscureText;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final AsyncSnapshot<String>? errSnapshot;
  final TextCapitalization? textCapitalization;
  final TextEditingController? textEditingController;
  final String? hintText;
  final String? labelText;
  final FilteringTextInputFormatter? filteringTextInputFormatter;
  final LengthLimitingTextInputFormatter? lengthLimitingTextInputFormatter;
  final TextInputType? textInputType;

  const InputField(
      {Key? key,
      this.prefix,
      this.textCapitalization,
      this.textEditingController,
      this.hintText,
      this.labelText,
      this.filteringTextInputFormatter,
      this.lengthLimitingTextInputFormatter,
      this.textInputType,
      this.obscureText,
      this.errSnapshot,
      this.onChanged,
      this.maxLines,
      this.onSubmit,
      this.enabled})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<TextFieldProvider>(
      create: (context) => TextFieldProvider(),
      child: Consumer<TextFieldProvider>(
        builder: (context, fieldModel, child) => TextField(
          controller: textEditingController,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: size.width * 0.04,
            color: Colors.black,
          ),
          obscureText:
              !fieldModel.getVissiblePassword && obscureText! ? true : false,
          inputFormatters: [
            filteringTextInputFormatter!,
            lengthLimitingTextInputFormatter!
          ],
          textCapitalization: textCapitalization!,
          onChanged: onChanged,
          enabled: enabled ?? true,
          maxLines: maxLines,
          onSubmitted: onSubmit,
          keyboardType: textInputType,
          decoration: InputDecoration(
            suffix: !obscureText!
                ? errSnapshot!.hasData
                    ? Icon(
                        Icons.check,
                        size: size.width * 0.07,
                        color: Colors.blue,
                      )
                    : null
                : GestureDetector(
                    onTap: () => fieldModel.setVissiblePass =
                        !fieldModel.getVissiblePassword,
                    child: Icon(
                      fieldModel.getVissiblePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: errSnapshot!.hasData ? Colors.blue : Colors.black,
                    ),
                  ),
            errorText:
                errSnapshot!.hasError ? errSnapshot!.error.toString() : null,
            alignLabelWithHint: true,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size.width * 0.04,
              color:const Color(0xFFB9B9B9),
            ),
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: size.width * 0.04,
              color:const Color(0xFFB9B9B9),
            ),
            prefix: prefix,
            focusedBorder: errSnapshot!.hasData
                ?const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  )
                : const UnderlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.black),
                   
                  ),
            enabledBorder: errSnapshot!.hasData
                ? const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color:Colors.blue,
                      width: 2,
                    ),
                  )
                :const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.0,
                      color:Colors.black,
                    ),
                  ),
            labelText: labelText,
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}