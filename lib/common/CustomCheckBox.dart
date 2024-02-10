import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final bool? isChecked;
  final Color? selectedColor;
  final double? height, width, verticalPadding;

  CustomCheckBox({this.isChecked, this.selectedColor, this.height, this.width, this.verticalPadding});

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        width: widget.width ?? 18,
        height: widget.height ?? 18,
        margin: EdgeInsets.symmetric(vertical: widget.verticalPadding ?? 15),
        decoration: BoxDecoration(
          color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: _isSelected
              ? null
              : Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
        ),
        child: _isSelected
            ? Icon(
          Icons.check,
          color: Colors.white,
          size: 16,
        )
            : null,
      ),
    );
  }
}
