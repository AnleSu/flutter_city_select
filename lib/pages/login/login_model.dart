enum OPPLoginType {
  OPPLoginTypeUcar,// 员工账号
  OPPLoginTypeFranchisee,// 加盟商账号
}

class LoginModel {
  int empType;/// 员工类型：1：员工，2：店长，3：加盟商
  String accountId;
  int empId;
  String distributorId;


  String userId;//客户端自定义  -  用户id  神州员工就采用empId，加盟商就采用accountId
  OPPLoginType loginType;

  LoginModel({this.empType, this.accountId, this.empId, this.distributorId});

  LoginModel.fromJson(Map<String, dynamic> json) {
    empType = json['empType'];
    accountId = json['accountId'];
    empId = json['empId'];
    distributorId = json['distributorId'];
    userId = empType != 3 ? empId : accountId;
    loginType = empType != 3 ? OPPLoginType.OPPLoginTypeUcar : OPPLoginType.OPPLoginTypeFranchisee;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empType'] = this.empType;
    data['accountId'] = this.accountId;
    data['empId'] = this.empId;
    data['distributorId'] = this.distributorId;
    data['userId'] = this.userId;
    data['loginType'] = this.loginType;
    return data;
  }
}