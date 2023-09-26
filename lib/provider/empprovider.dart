import 'package:first_project/widget/employe_model.dart';
import 'package:flutter/material.dart';
import '../widget/database/database.dart';

class EmpolyeeProvider with ChangeNotifier {
  DB_helper db = DB_helper();
  //<Employee> is model name
  //_empolye is just a name
  //getdata is just a name
  //Get_Empolye_list is from database
  late Future<List<Employee>> _employe;
  Future<List<Employee>> get Empolye => _employe;
  Future<List<Employee>> getdata() {
    _employe = db.Get_Empolye_list();
    return _employe;
  }

  // this notifylisner is use to change values
  notifyListeners();
}
