import 'dart:convert';

import 'package:error_handling/model/post.dart';
import 'package:error_handling/service/fake_api_client.dart';

// 여기서 json 값으로 바꿔주는 걸 해준다.
class PostService {
  final httpClient = FakeApiClient();

  // ApiClient 에서 오류를 넘겨도 그냥 UI 의 FutureBuilder 가 처리하도록 넘겨준다.
  // 이게 가능한거는 일단 FutureBuilder 는 Post 라고 생각하고 미리 받아놓으니깐 이 문장들이 이상없는거고 그게 나중에 막상 열었을 때 다른게 나오니깐
  // FutureBuilder 가 황당해 하면서 예정된 에러를 보여주는 거지..
  Future<Post> getOnePost() async {
    var getResponse = await httpClient.getResponseBody();
    print('getResponse value is  $getResponse');
    var result = Post.fromJson(jsonDecode(getResponse));
    print('result value is $result');
    return result;
  }
}
