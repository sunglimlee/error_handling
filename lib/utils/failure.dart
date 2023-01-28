class Failure {
  final String message;

  Failure(this.message);

  // 이거 참 멋있다. 이렇게 내가 원하는 toString() 변수를 오버라이딩 할 수 있구나..
  @override
  String toString() {
    return message;
  }
}