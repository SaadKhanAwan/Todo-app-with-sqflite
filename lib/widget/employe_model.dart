class Employee {
  int? id;
  late String name;
  late int salary;
  late String profetion;

  Employee({
    this.id,
    required this.name,
    required this.salary,
    required this.profetion,
  });

  // Convert a Employee into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'salary': salary,
      'profetion': profetion,
      // 'gender': gender,
    };
  }

  // Convert a Map to a Employee Object
  Employee.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    salary = map['salary'];
    profetion = map['profetion'];
  }
}
