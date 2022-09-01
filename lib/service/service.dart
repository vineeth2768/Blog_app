import 'package:blog/model/blog_model.dart';
import 'package:flutter/cupertino.dart';

class BlogService extends ChangeNotifier {
  List<BlogModel> state = [];
  int id = 0;

  void addBlog(BlogModel blog) {
    final int id = state.length + 1;
    final BlogModel newBlog =
        BlogModel(id: id, title: blog.title, blogContent: blog.blogContent);
    state.add(newBlog);
    notifyListeners();
  }

  void updateBlog(BlogModel blog) {
    final int index = state.indexWhere((element) => element.id == blog.id);
    state[index] = blog;
    notifyListeners();
  }

  void deleteBlog(BlogModel blog) {
    state.removeWhere((element) => element.id == blog.id);
    notifyListeners();
  }

  BlogModel? get viewBlog {
    return id != 0
        ? state.where((element) => element.id == id).toList().first
        : null;
  }
}
