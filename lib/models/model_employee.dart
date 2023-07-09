class ModelEmployee {
  int? id;
  String? employeeName;
  String? role;
  String? fromDate;
  String? toDate;

  ModelEmployee({
    this.id,
    this.employeeName = '',
    this.role = '',
    this.fromDate = '',
    this.toDate = '',
  });

  ModelEmployee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeName = json['employee_name'].toString();
    role = json['role'].toString();
    fromDate = json['from_date'].toString();
    toDate = json['to_date'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_name'] = employeeName;
    data['role'] = role;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;

    return data;
  }
}
