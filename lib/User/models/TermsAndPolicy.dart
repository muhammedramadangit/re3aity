class TermsAndPolicyModel {
  String msg;
  Data data;

  TermsAndPolicyModel({this.msg, this.data});

  TermsAndPolicyModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String policy;
  String condition;
  String name;
  String logo;
  String twahedcommission;
  String mssagecommission;
  String doctorcommission;
  String elagcommission;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.policy,
        this.condition,
        this.name,
        this.logo,
        this.twahedcommission,
        this.mssagecommission,
        this.doctorcommission,
        this.elagcommission,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    policy = json['policy'];
    condition = json['condition'];
    name = json['name'];
    logo = json['logo'];
    twahedcommission = json['twahedcommission'];
    mssagecommission = json['mssagecommission'];
    doctorcommission = json['doctorcommission'];
    elagcommission = json['elagcommission'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['policy'] = this.policy;
    data['condition'] = this.condition;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['twahedcommission'] = this.twahedcommission;
    data['mssagecommission'] = this.mssagecommission;
    data['doctorcommission'] = this.doctorcommission;
    data['elagcommission'] = this.elagcommission;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
