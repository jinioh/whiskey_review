import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 30.0,
        ),
        children: [
          const Text(
            "다음 정보를 모두 입력해",
            textAlign: TextAlign.center,
          ),
          const TextField(
            autocorrect: false,
            autofocus: true,
            decoration: InputDecoration(
              hintText: '이름',
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
          const TextField(
            autocorrect: false,
            decoration: InputDecoration(
              hintText: "이메일",
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const TextField(
            autocorrect: false,
            decoration: InputDecoration(
              hintText: "비밀번호",
            ),
            textInputAction: TextInputAction.next,
            obscureText: true,
          ),
          const TextField(
            autocorrect: false,
            decoration: InputDecoration(
              hintText: "비밀번호 확인",
            ),
            textInputAction: TextInputAction.done,
            obscureText: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                value: false,
                onChanged: (_) {},
              ),
              const Text('이용약관에 동의합니다.'),
            ],
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: const Text('제출'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
