class BlogModel {
  final int? id;
  final String title;
  final String blogContent;
  final String? image;

  BlogModel({
    this.id,
    required this.title,
    required this.blogContent,
    this.image,
  });
}
