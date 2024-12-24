class LoadJson{
  String? author,title,description,url,urlToImage,publishedAt,content;
  LoadJson({this.author,this.content,this.url,this.urlToImage,this.title,this.description,this.publishedAt});
  LoadJson.fromJson(Map<String,dynamic> json){
    author=json['author'];
    title=json['title'];
    content=json['content'];
    url=json['url'];
    urlToImage=json['urlToImage'];
    description=json['description'];
    publishedAt=json['publishedAt'];
  }
}