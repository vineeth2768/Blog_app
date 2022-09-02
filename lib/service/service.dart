import 'package:blog/model/blog_model.dart';
import 'package:flutter/cupertino.dart';

class BlogService extends ChangeNotifier {
  List<BlogModel> state = [];
  int id = 0;
  ///// Add Blog
  void addBlog(BlogModel blog) {
    final int id = state.length + 1;
    final BlogModel newBlog = BlogModel(
      id: id,
      title: blog.title,
      blogContent: blog.blogContent,
      image: blog.image,
    );
    state.add(newBlog);
    notifyListeners();
  }

  //// Update Blog
  void updateBlog(BlogModel blog) {
    final int index = state.indexWhere((element) => element.id == blog.id);
    state[index] = blog;
    notifyListeners();
  }

  /// Delete Blog
  void deleteBlog(BlogModel blog) {
    state.removeWhere((element) => element.id == blog.id);
    notifyListeners();
  }

  /// View Blog
  BlogModel? get viewBlog {
    // if id is zero reutnr null otherwise return blog
    return id != 0
        ? state.where((element) => element.id == id).toList().first
        : null;
  }
}
