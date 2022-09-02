// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:blog/model/blog_model.dart';
import 'package:blog/service/service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ScreenCreateBlog extends StatelessWidget {
  ScreenCreateBlog({Key? key}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<File?> imageFileNotifier = ValueNotifier(null);

  BlogModel? blogModel;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      blogModel = Provider.of<BlogService>(context, listen: false).viewBlog;

      if (blogModel != null) {
        _titleController.text = blogModel!.title;
        _contentController.text = blogModel!.blogContent;
        if (blogModel?.image != null) {
          imageFileNotifier.value = File(blogModel!.image!);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Consumer(builder: (context, _, __) {
          final int id = Provider.of<BlogService>(context).id;
          return Text(id == 0 ? "Create Blog" : "Edit Blog");
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //// Title Add Section ///////////

                TextFormField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    hintText: "Enter title here",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.startsWith(" ")) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                ///// Blog Add Selection /////////
                TextFormField(
                  controller: _contentController,
                  maxLength: 1000,
                  maxLines: 15,
                  decoration: const InputDecoration(
                    hintText: "Write your blog here...",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.startsWith(" ")) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),

                ///// Image Add Section ///////////
                InkWell(
                  child: Card(
                    elevation: 10,
                    child: ValueListenableBuilder(
                      valueListenable: imageFileNotifier,
                      builder: (context, File? imageFile, __) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * .40,
                          height: MediaQuery.of(context).size.width * .40,
                          child: imageFile != null
                              ? Image.file(imageFile)
                              : const Icon(Icons.add_photo_alternate_rounded),
                        );
                      },
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (ctx) {
                          return ListView(
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Camera'),
                                onTap: () async {
                                  Navigator.pop(ctx);
                                  final image = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  if (image != null) {
                                    imageFileNotifier.value = File(image.path);
                                  }
                                },
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: const Icon(Icons.photo),
                                title: const Text('Gallery'),
                                onTap: () async {
                                  Navigator.pop(ctx);
                                  final image = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  if (image != null) {
                                    imageFileNotifier.value = File(image.path);
                                  }
                                },
                              ),
                            ],
                          );
                        });
                  },
                ),
                const SizedBox(height: 10),

                ////// Post Button//////////////////////
                MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () {
                    final BlogModel blog = BlogModel(
                      id: blogModel?.id,
                      title: _titleController.text.trim(),
                      blogContent: _contentController.text.trim(),
                      image: imageFileNotifier.value?.path,
                    );

                    final formState = _formKey.currentState!;
                    if (formState.validate()) {
                      final int id =
                          Provider.of<BlogService>(context, listen: false).id;
                      if (id == 0) {
                        Provider.of<BlogService>(context, listen: false)
                            .addBlog(blog);
                      } else {
                        Provider.of<BlogService>(context, listen: false)
                            .updateBlog(blog);
                      }

                      Navigator.pop(context);
                    }
                  },
                  color: Colors.blue,
                  child: Consumer(builder: (context, _, __) {
                    final int id = Provider.of<BlogService>(context).id;
                    return Text(
                      id == 0 ? "Post Blog" : "Update Blog",
                      style: const TextStyle(color: Colors.white),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
