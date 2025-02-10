import 'dart:io';

import 'package:flutter_supabase/core/error/failure.dart';
import 'package:flutter_supabase/core/error/server_exception.dart';
import 'package:flutter_supabase/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_supabase/features/blog/data/models/blog_model.dart';
import 'package:flutter_supabase/features/blog/domain/entities/blog.dart';
import 'package:flutter_supabase/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String posterId,
      required List<String> topics}) async {
    try {
      BlogModels blogModels = BlogModels(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: '',
          topics: topics,
          updatedAt: DateTime.now());

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          image: image, blogModels: blogModels);

      final blog = await blogRemoteDataSource
          .uploadBlog(blogModels.copyWith(imageUrl: imageUrl));

      return right(blog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
