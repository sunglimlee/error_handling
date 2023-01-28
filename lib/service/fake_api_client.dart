import 'dart:io';

/// API Client Service 에러도 throw 한다.
class FakeApiClient {
  Future<String> getResponseBody() async {
    await Future.delayed(const Duration(microseconds: 500));
    //! No Internet Connection
    // throw const SocketException('No Internet');

    //! 404 error
    // throw HttpException('404');

    //! Invalid JSON (throw FormatException)
    // return 'abce';

    return '{"userId":1,"id":1,"title":"nice title","body":"cool body"}';
  }
}
