import 'dart:convert';

import 'package:error_handling/model/post.dart';
import 'package:error_handling/service/fake_api_client.dart';

// 여기서 json 값으로 바꿔주는 걸 해준다.
class PostService {
  final httpClient = FakeApiClient();

  Future<Post> getOnePost() async {
    var getResponse = await httpClient.getResponseBody();
    print('getResponse value is  $getResponse');
    var result = Post.fromJson(jsonDecode(getResponse));
    print('result value is $result');
    return result;
  }
}
