import 'dart:convert';
import 'dart:io';

import 'package:error_handling/model/post.dart';
import 'package:error_handling/service/fake_api_client.dart';
import 'package:error_handling/utils/custom_exception.dart';

// 여기서 json 값으로 바꿔주는 걸 해준다.
class PostService {
  final httpClient = FakeApiClient();

  // ApiClient 에서 오류를 넘겨도 그냥 UI 의 FutureBuilder 가 처리하도록 넘겨준다.
  // 이게 가능한거는 일단 FutureBuilder 는 Post 라고 생각하고 미리 받아놓으니깐 이 문장들이 이상없는거고 그게 나중에 막상 열었을 때 다른게 나오니깐
  // FutureBuilder 가 황당해 하면서 예정된 에러를 보여주는 거지..
  Future<Post?> getOnePost() async {
    String getResponse;
    Post? result;
    try {
      getResponse = await httpClient.getResponseBody();
      print('getResponse value is  $getResponse');
      result = Post.fromJson(jsonDecode(getResponse));
      print('result value is $result');
      return result;
      // Api Client 에서 에러를 던졌을 때 여기서 on 으로 Exception 을 받을 수 있다. 현재는 그냥 print 처리만 했다.
      // 중요한 사실은 여기 Repository 안에서 예외 처리를 했다는 점이다. 할 수 있지...
      // 근데 이 문제는 전체 예외가 일어났을 때는 어떻게 할 건데..
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    } on Exception {
      // 이렇게 하면 알 수 없는 에러를 발생할 수 있게지?
      print("알 수 없는 에러 발생");
      // 사용자 정의 Exception 을 만들어서 넘겨주자.
      throw CustomException('알 수 없는 예외가 발생하였습니다.');
    }
  }
}
