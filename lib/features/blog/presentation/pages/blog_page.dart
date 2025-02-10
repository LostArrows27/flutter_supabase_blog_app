import 'package:flutter/material.dart';
import 'package:flutter_supabase/features/blog/presentation/pages/add_new_blog_page.dart';

class BlogPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlogPage.route());
              },
              icon: Icon(Icons.add_circle))
        ],
      ),
    );
  }
}
