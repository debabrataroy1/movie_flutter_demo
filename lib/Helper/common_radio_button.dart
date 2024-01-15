import 'package:flutter/material.dart';
import 'package:movie_flutter_demo/Constants/font_size_constants.dart';
import 'package:movie_flutter_demo/Extensions/build_context_extension.dart';

class AppRadioButton extends StatefulWidget {
  final List<String> items;
  final String label;
  final ValueChanged<String>? onChange;
  const AppRadioButton({required this.label, required this.items, this.onChange, super.key});

  @override
  State<AppRadioButton> createState() => _AppRadioButtonState();
}

class _AppRadioButtonState extends State<AppRadioButton> {
  String _radioValue = "";

  void _handleRadioValueChange(String? value) {
    setState(() {
      _radioValue = value ?? '';
    });
    if (widget.onChange != null && value != null) {
      widget.onChange!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField(builder: (FormFieldState<bool> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label),
          Row(
              children: widget.items.map((item) {
                return Row(children: [
                  Radio(
                    value: item,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                  Text(item, style: const TextStyle(fontSize: AppFontSize.regular)
                  )
                ]);
              }).toList()),
          if (state.hasError)
            Text(
                state.errorText ?? '',
                style: const TextStyle(color: Colors.red)
            )
        ]);
    }, validator: (value) {
      if (_radioValue == "") {
        return context.l10n.genderIsRequired;
      }
      return null;
    }
    );
  }
}
