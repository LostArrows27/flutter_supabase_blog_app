import 'package:flutter_supabase/core/error/failure.dart';
import 'package:flutter_supabase/core/usecase/usecase.dart';
import 'package:flutter_supabase/features/blog/domain/entities/blog.dart';
import 'package:flutter_supabase/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class GetAllBlog implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlog(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlog();
  }
}
