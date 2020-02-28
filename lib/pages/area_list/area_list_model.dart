class DeptList {
  String deptName;
  List<DeptListChildren> children;
  String deptId;

  DeptList({this.deptName, this.children, this.deptId});

  DeptList.fromJson(Map<String, dynamic> json) {
    deptName = json['deptName'];
    if (json['children'] != null) {
      children = new List<DeptListChildren>();
      json['children'].forEach((v) {
        children.add(new DeptListChildren.fromJson(v));
      });
    }
    deptId = json['deptId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deptName'] = this.deptName;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    data['deptId'] = this.deptId;
    return data;
  }
}

class DeptListChildren {
  String deptName;
  String deptId;

  DeptListChildren({this.deptName, this.deptId});

  DeptListChildren.fromJson(Map<String, dynamic> json) {
    deptName = json['deptName'];
    deptId = json['deptId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deptName'] = this.deptName;
    data['deptId'] = this.deptId;
    return data;
  }
}