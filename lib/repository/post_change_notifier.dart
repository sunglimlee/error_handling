import 'package:error_handling/model/post.dart';
import 'package:error_handling/repository/post_service.dart';
import 'package:error_handling/utils/failure.dart';
import 'package:flutter/cupertino.dart';

/*
기존방법은 Api Client 에서 데이터를 받아서 그 받은 데이터를 가지고 FutureBuilder 가 핸들링 하도록 했다.
그러면서 에러처리도 Repository 단에서 하도록 하면서 CustomException & Failure 클래스를 만들어서 FutureBuilder 에 던져주기도 하였다.
이번에는 그러한 처리를 ChangeNotifier 를 이용해서 한다. 그러면 FutureBuilder 가 필요없겠지..
 */

// 이런 깨알같은 실수 enum 소문자이며, 마지막에 ; 세미콜론 안들어간다는것... 이런걸 왜 이제서야 아는거지? enum 을 이렇게 사용한적이 없었나??????
enum NotifyState { initial, loading, loaded }

class PostChangeNotifier extends ChangeNotifier {
  PostChangeNotifier(); // 생성자

  // PostService 를 그대로 쓰는구나..
  final PostService _postService = PostService();

  // 이런 또 다른 깨알같은 문제들... NotifyState.initial 이라고 쓴다는것..
  NotifyState _notifyState = NotifyState.initial;

  Failure? _failure;

  Post? _post;

  Post? get post => _post;

  Failure? get failure => _failure;

  NotifyState get notifyState => _notifyState;

  set post(Post? value) {
    _post = value;
    notifyListeners();
  }

  set failure(Failure? value) {
    _failure = value;
    notifyListeners();
  }

  set notifyState(NotifyState value) {
    _notifyState = value;
    notifyListeners();
  }

  void getOnePost() async {
    notifyState =
        NotifyState.loading; // 로딩을 해야하지.. 그리고 이건 set 을 사용했으므로 이렇게 들어가야 하는게 맞다.
    try {
      var post = await _postService.getOnePost();
      _post = post;
    } on Failure catch (f) {
      // 이문장은 외워야 겠다. Failure 사용자 정의 객체를 통해서 f 값을 다시 받네..
      failure = f;
    }
    notifyState = NotifyState.loaded;
  }
}
