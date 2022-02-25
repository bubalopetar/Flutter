import 'package:flutter/material.dart';

class FloatingButtonWidget extends StatefulWidget {
  FloatingButtonWidget(
      {Key key,
      @required this.activeColor,
      @required this.activeCategory,
      this.activeScreen,
      this.setStateCallback})
      : super(key: key);

  Color activeColor;
  List<String> activeCategory;
  dynamic activeScreen;
  Function(String screen, String category) setStateCallback;
  @override
  _FloatingButtonWidgetState createState() => _FloatingButtonWidgetState();
}

class _FloatingButtonWidgetState extends State<FloatingButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: Icon(Icons.category),
      iconSize: 50,
      iconEnabledColor: widget.activeColor,
      items: widget.activeCategory.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (String category) {
        //print(category);
        //print(widget.activeScreen.toString());

        if (category != 'Nema kategorija') {
          widget.setStateCallback(
              widget.activeScreen.runtimeType.toString(), category);
        }
      },
    );
  }
}
