import 'package:flutter/material.dart';
import 'package:re3aity/common/AnimatedWidget.dart';
import 'package:re3aity/theme/color.dart';

class AdvancedService extends StatefulWidget {
  @override
  _AdvancedServiceState createState() => _AdvancedServiceState();
}

class _AdvancedServiceState extends State<AdvancedService> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 150,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ServiceRow(
            label: "طبيب",
            onPressed: () {},
          ),
          ServiceRow(
            label: "خدمات منزلية",
            onPressed: () {},
          ),
          ServiceRow(
            label: "سباكة",
            onPressed: () {},
          ),
          ServiceRow(
            label: "كهرباء",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class ServiceRow extends StatefulWidget {
  final String? label;
  final Function? onPressed;

  const ServiceRow({Key? key, this.label, this.onPressed}) : super(key: key);

  @override
  _ServiceRowState createState() => _ServiceRowState();
}

class _ServiceRowState extends State<ServiceRow> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = false;
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

      child: AnimatedWidgets(
        duration: 1,
        horizontalOffset: 0,
        virticaloffset: -50,
        child: Container(
          height: 30,
          color: Colors.transparent,
          margin: EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label ?? "",
                style: TextStyle(
                  fontSize: 12,
                  color: ThemeColor.lighterGreyText,
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastLinearToSlowEaseIn,
                width: 18,
                height: 18,
                margin: EdgeInsets.symmetric(vertical: 0),
                decoration: BoxDecoration(
                  color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: _isSelected == true
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
            ],
          ),
        ),
      ),
    );
  }
}
