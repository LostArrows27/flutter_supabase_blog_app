import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase/core/usecase/usecase.dart';
import 'package:flutter_supabase/features/blog/domain/entities/blog.dart';
import 'package:flutter_supabase/features/blog/domain/usecases/get_all_blog.dart';
import 'package:flutter_supabase/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlog _getAllBlog;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlog getAllBlog,
  })  : _uploadBlog = uploadBlog,
        _getAllBlog = getAllBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));

    on<BlogUpload>(_onBlogUpload);
    on<FetchAllBlogs>(_onFetchAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics));

    res.fold((l) => emit(BlogFailure(l.message)),
        (r) => emit(BlogUploadSuccess()));
  }

  void _onFetchAllBlogs(FetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _getAllBlog(NoParams());

    res.fold((l) => emit(BlogFailure(l.message)), (r) => emit(BlogDisplaySuccess(r)));
  }
}
