import 'package:first_project/screens/add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../provider/empprovider.dart';
import '../widget/employe_model.dart';
import '../widget/update.dart';

class homepage extends StatefulWidget {
  homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  // this is for to initiazilse dataabse on this file
  DB_helper? dBhelper = DB_helper();
  @override
  Widget build(BuildContext context) {
    debugPrint("whole Screen Build checkig provider working properly?");
    // this is for providder
    final Empolyeprovider =
        Provider.of<EmpolyeeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Employe list"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => add()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      //drawer is class define in drawer_class
      // drawer: drawer(),
      body: Column(
        children: [
          // here this consumer is use to build specific widget
          Consumer<EmpolyeeProvider>(builder: (context, value, child) {
            return FutureBuilder(
                //Empolyeprovider is provider consider upper
                //get data is from provider page (EployeeProvider)
                future: Empolyeprovider.getdata(),
                builder: (context, AsyncSnapshot<List<Employee>> snapshort) {
                  if (snapshort.hasData) {
                    print("Number of empolyes are ${snapshort.data!.length}");
                    // just return problem
                    //this comsumer is use for provider to change the vlaues
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshort.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shadowColor: Colors.grey,
                                elevation: 6.0,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshort.data![index].name
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          snapshort.data![index].profetion
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          snapshort.data![index].salary
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 200,
                                        )
                                      ],
                                    ),
                                    // edit function
                                    InkWell(
                                        onTap: () async {
                                          print("working");
                                          var result =
                                              await Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                            return UpdateEmployeeScreen(
                                                emp: snapshort.data![index]);
                                          }));

                                          if (result == 'done') {
                                            Empolyeprovider.notifyListeners();
                                          }
                                        },
                                        child: Icon(Icons.edit)),
                                    //delete function
                                    InkWell(
                                        onTap: () {
                                          print("deleted");
                                          dBhelper!.delete(
                                              snapshort.data![index].id!);
                                          Empolyeprovider.notifyListeners();
                                        },
                                        child: Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  return Text("");
                });
          })
        ],
      ),
    );
  }
}
