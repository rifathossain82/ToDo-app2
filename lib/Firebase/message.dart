class Message_Demo{
  String title;
  String des;

  Message_Demo(this.title,this.des);

  Message_Demo.fromJson(Map<dynamic,dynamic> json):
        title=json['title'] as String,
        des=json['des'] as String;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['des'] = this.des;
    return data;
  }


}