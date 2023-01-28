/*
FutureBuilder 는 Future 에 의해서 값이 바뀌는 건데... 맞았는데 외부에 Future<String> 함수를 선언했어야 했고 그걸 null 가능토록 해주었어야 했다.
버턴을 눌렀을 때 값이 바뀌도록 하고 싶다는거지.. 그러면 외분에서 만들어둔 PostService 를 통해서 돌아온 값을 위줄의 Future<String> 에 넣어서 리턴해 줄 수 있다.
 */
import 'package:division/division.dart';
import 'package:error_handling/model/post.dart';
import 'package:error_handling/repository/post_service.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  // 이것만 이렇게 변수로 있으니깐 갑자기 해결되잖아... 그러니깐 관리하고자 하는 변수들을 선언하는게 중요하다.
  // 여기서 선언해야지 나중에 setState 로 바꾸었을 때 해결되지..
  // 여기의 관건은 FutureBuilder 가 모든 에러처리를 담당해서 사용자에게 보여주는 역할을 한다.
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final postService = PostService();
  Future<Post?>? postFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: postFuture,
                  // 보이지? null 이 될 수 있기 때문에 이제 괜찮은 거다. 내가 생각한게 맞았다. 단지 null 체크를 하지 않아서 그렇게 된거지..
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (asyncSnapshot.hasError) {
                      final error = asyncSnapshot.error;
                      return Txt(
                        error.toString(),
                        style: TxtStyle()
                          ..fontSize(30)
                          ..textColor(Colors.pink),
                      );
                    } else if (asyncSnapshot.hasData) {
                      final post = asyncSnapshot.data;
                      return Txt(
                        post.toString(),
                        style: TxtStyle()
                          ..fontSize(30)
                          ..textColor(Colors.red),
                      );
                    } else {
                      return const Txt('Press the button. 👇');
                    }
                  }),

              const SizedBox(
                height: 30,
              ),
              // 버턴
              TextButton(
                  onPressed: () {
                    setState(() {
                      postFuture = postService.getOnePost();
                    });
                  },
                  child: const Text('가져오기')),
            ],
          ),
        )));
  }
}
