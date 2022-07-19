class CommentEntinty {
  final int id;
  final String title;
  final String content;
  final String date;
  final String email;
  CommentEntinty.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        date = json['date'],
        email = json['author']['email'];
}
