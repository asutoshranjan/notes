
class TodoModel{
  String? title;
  String? description;
  bool? isDone;
  String? createdAt;
  String? userId;
  String? docId;

  TodoModel({this.title, this.description, this.isDone, this.createdAt, this.userId, this.docId});
  TodoModel.fromJson(Map<String,dynamic> json){
    title = json['title'];
    description = json['description'];
    isDone = json['isDone'];
    createdAt = json['createdAt'];
    userId = json['userId'];
    docId = json['docId'];
  }

  Map<String, dynamic> toJson(){
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['isDone'] = isDone;
    data['createdAt'] = createdAt;
    data['userId'] = userId;
    data['docId'] = docId;
    return data;
  }
}
