import 'package:flutter/material.dart';
import 'package:flutter_supabase/core/theme/app_pallete.dart';
import 'package:flutter_supabase/core/utils/calculate_reading_time.dart';
import 'package:flutter_supabase/core/utils/format_date.dart';
import 'package:flutter_supabase/features/blog/domain/entities/blog.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));

  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'By ${blog.posterName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppPallete.greyColor,
                        fontSize: 16,
                      ),
                      '${formatDateBydMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min'),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        blog.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    blog.content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 2,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
