import 'package:first_project/widget/button.dart';
import 'package:first_project/widget/database/database.dart';
import 'package:first_project/widget/employe_model.dart';
import 'package:first_project/widget/field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/empprovider.dart';

class add extends StatefulWidget {
  const add({super.key});

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  // this is textfields
  final name_controller = TextEditingController();
  final salary_controller = TextEditingController();
  final profession_controller = TextEditingController();
  //this for database
  DB_helper? dBhelper = DB_helper();

  @override
  Widget build(BuildContext context) {
    final Empolyeprovider = Provider.of<EmpolyeeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Employe",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // here this field is textfield
            field(
              contrl: name_controller,
              hint: "Add Name",
              icoon: Icon(Icons.man),
            ),
            field(
                contrl: profession_controller,
                hint: "Add Professtion",
                icoon: Icon(Icons.work)),
            field(
                type: TextInputType.number,
                contrl: salary_controller,
                hint: "Add Salary",
                icoon: Icon(Icons.attach_money_sharp)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: button(
                  name: "Add Employe",
                  callback: () {
                    var user = name_controller.text;
                    var prof = profession_controller.text;
                    var sal = salary_controller.text;
                    dBhelper!
                        .insert(Employee(
                            name: user,
                            salary: int.parse(sal),
                            profetion: prof))
                        .then((value) => {print("employe added")})
                        .onError((error, stackTrace) => {print("error found")});

                    name_controller.clear();
                    profession_controller.clear();
                    salary_controller.clear();
                    //this navigator is use to remove the employe adding page
                    Navigator.pop(context);
                    // this is use to change value immeditly
                    Empolyeprovider.notifyListeners();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 29.0),
              child: button(
                  name: "View List",
                  callback: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
