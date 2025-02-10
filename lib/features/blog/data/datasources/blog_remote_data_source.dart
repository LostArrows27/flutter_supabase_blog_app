import 'dart:io';

import 'package:flutter_supabase/core/error/server_exception.dart';
import 'package:flutter_supabase/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModels> uploadBlog(BlogModels blog);
  Future<String> uploadBlogImage(
      {required File image, required BlogModels blogModels});

  Future<List<BlogModels>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<BlogModels> uploadBlog(BlogModels blog) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blog.toJson())
          .select()
          .single();

      return BlogModels.fromJson(blogData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModels blogModels}) async {
    try {
      String imagePath = '/${blogModels.posterId}/${Uuid().v4()}';

      await supabaseClient.storage.from('blog_images').upload(imagePath, image);

      return supabaseClient.storage.from('blog_images').getPublicUrl(imagePath);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModels>> getAllBlogs() async {
    try {
      final res =
          await supabaseClient.from('blogs').select('*, profiles(name)');

      return res
          .map((blog) => BlogModels.fromJson(blog)
              .copyWith(posterName: blog['profiles']['name']))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
