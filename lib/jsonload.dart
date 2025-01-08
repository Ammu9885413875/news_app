class LoadJson{
  String? author,title,description,url,urlToImage,content;
  DateTime? timeStamp;
  String? publishedAt;
  LoadJson({this.timeStamp,this.author,this.content,this.url,this.urlToImage,this.title,this.description,this.publishedAt});
  LoadJson.fromJson(Map<String,dynamic> json){
    author=json['author'];
    title=json['title'];
    content=json['content'];
    url=json['url'];
    urlToImage=json['urlToImage'];
    description=json['description'];
    publishedAt=json['publishedAt'];
  }
  Map<String, dynamic> toJson(){
    return {
      'timeStamp':timeStamp,
      'author':author,
      'title':title,
      'description':description,
      'publishedAt':publishedAt,
      'urlToImage':urlToImage,
    };
  }
}