import 'package:blog/model/blog_model.dart';
import 'package:blog/service/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenViewBlog extends StatelessWidget {
  const ScreenViewBlog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BlogModel blog = Provider.of<BlogService>(context).viewBlog!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Blog"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                blog.title,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              const Divider(),
              const SizedBox(height: 5),
              Text(blog.blogContent),
            ],
          ),
        ),
      ),
    );
  }
}
