class RemoveModel {
  String msg;
  String data;

  RemoveModel({this.msg, this.data});

  RemoveModel.fromJson(Map<String, dynamic> json) {    
    this.msg = json['msg'];
    this.data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }

}
