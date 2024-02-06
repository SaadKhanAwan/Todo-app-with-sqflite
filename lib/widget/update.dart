import 'package:flutter/material.dart';
import '../database/database.dart';
import 'employe_model.dart';

class UpdateEmployeeScreen extends StatefulWidget {
  // here emp is short name of Employee Model class initialzise by devolper
  final Employee emp;
  const UpdateEmployeeScreen({Key? key, required this.emp}) : super(key: key);
  @override
  State<UpdateEmployeeScreen> createState() => _UpdateEmployeeScreen();
}

class _UpdateEmployeeScreen extends State<UpdateEmployeeScreen> {
  // here this is use to initialize dataabse
  DB_helper? dBhelper = DB_helper();
  late String name;
  late String password;
  late int salary;

  // here this key is use for validatorization
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Employee'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  //here emp is define for short form of model (Employee)
                  initialValue: widget.emp.name,
                  decoration: const InputDecoration(hintText: 'Employee Name'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide Employee Name';
                    }
                    name = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.emp.profetion.toString(),
                  decoration:
                      const InputDecoration(hintText: 'Employee professtion'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide Employee profession';
                    }
                    password = value;

                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.emp.salary.toString(),
                  decoration:
                      const InputDecoration(hintText: 'Employee salary'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide Employee salary';
                    }
                    salary = int.parse(value);

                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var emp = Employee(
                          id: widget.emp.id,
                          name: name,
                          salary: salary,
                          profetion: password,
                        );
                        var result = await dBhelper!.updateQuantity(emp);

                        if (result > 0) {
                          Navigator.pop(context, 'done');
                        }
                      }
                    },
                    child: const Text('Update')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
