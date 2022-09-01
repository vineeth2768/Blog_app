import 'package:blog/model/blog_model.dart';
import 'package:blog/routes/routes.dart';
import 'package:blog/service/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<BlogService>(context, listen: false).id = 0;
          Navigator.pushNamed(context, routeCreateBlog);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Blogs"),
      ),
      body: Consumer(
        builder: (context, _, __) {
          final List<BlogModel> blogs = Provider.of<BlogService>(context).state;

          return ListView.builder(
            itemBuilder: (context, index) {
              final BlogModel blog = blogs[index];
              return Card(
                child: ListTile(
                  title: Text(blog.title),
                  subtitle: Text(
                    blog.blogContent,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Provider.of<BlogService>(context, listen: false).id =
                              blog.id!;
                          Navigator.pushNamed(context, routeCreateBlog);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<BlogService>(context, listen: false)
                              .deleteBlog(blog);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                  onTap: () {
                    Provider.of<BlogService>(context, listen: false).id =
                        blog.id!;
                    Navigator.pushNamed(context, routeViewBlog);
                  },
                ),
              );
            },
            itemCount: blogs.length,
          );
        },
      ),
    );
  }
}
