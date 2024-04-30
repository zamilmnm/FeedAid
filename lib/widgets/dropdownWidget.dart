import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import '../APIs/food/food.dart';
import '../constants.dart';

class dropdownWidget extends StatefulWidget {

  const dropdownWidget({
    Key? key
  }) : super(key: key);

  @override
  State<dropdownWidget> createState() => _dropdownWidgetState();
}

class _dropdownWidgetState extends State<dropdownWidget> {
  List<Food> foodList = [];

  Future<List> fetchFood() async {
    var url = "$path/back_end/food/view.php";

    try {
      final response = await http.get(Uri.parse(url));
      final body = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          var jsonResult = jsonDecode(response.body);
          setState(() {
            for (Map food in jsonResult) {
              foodList.add(Food.fromJson(food.cast()));
            }
          });
        }
      }
    }
    on SocketException {
      throw Exception("Network Connectivity Error");
    }
    throw Exception("Fetch Data Error");
  }


  @override
  void initState() {
    super.initState();
    fetchFood();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
        name: 'food',
        alignment: AlignmentDirectional.centerStart,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
          hintText: 'Food',
          hintStyle: const TextStyle(fontSize: 16, color: text_color_light),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: theme_color,
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
        items: foodList.map((Food f) => DropdownMenuItem(value: f.fId,child: Text(f.fName),)).toList()
    );
  }
}