import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart'; // 반드시 있어야 하는 라인 왜냐면 이걸로 다음 파일로 나눠버리거든.
part 'post.g.dart'; // json serializable 위해서 있어야 한다.

@freezed
class Post with _$Post {
  const factory Post(
      {required int userId,
      required int id,
      required String title,
      required String body}) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
