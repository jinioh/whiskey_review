import 'package:flutter/material.dart';
import 'package:flutter_application_1/tasting_note_input.dart';
import 'package:provider/provider.dart';

import '../data/tasting_note_detail.dart';
import '../data/whiskey_tasting_note.dart';
import '../provider/WhiskeyTastingNoteProvier.dart';

class ReviewWriteScreen extends StatefulWidget {
  const ReviewWriteScreen({super.key});

  @override
  State<ReviewWriteScreen> createState() => _ReviewWriteScreenState();
}

class _ReviewWriteScreenState extends State<ReviewWriteScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _wbCodeController = TextEditingController();
  final TextEditingController _abvController = TextEditingController();
  TabController? _tabController;

  WhiskeyTastingNote tastingNote = WhiskeyTastingNote(
    notes: {
      'Nose': TastingNoteDetails(),
      'Palate': TastingNoteDetails(),
      'Finish': TastingNoteDetails(),
    },
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _wbCodeController.dispose();
    _abvController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_tabController!.index < 2) {
      _tabController!.animateTo(_tabController!.index + 1);
    }
  }

  void _handleBack() {
    if (_tabController!.index > 0) {
      _tabController!.animateTo(_tabController!.index - 1);
    }
  }

  void _saveWhiskeyData() {
    final provider =
        Provider.of<WhiskeyTastingNoteProvider>(context, listen: false);
    provider.updateWhiskeyInfo(
      _nameController.text,
      _wbCodeController.text,
      _abvController.text,
    );

    // todo: 서버에 전달.
    print(tastingNote.name);
  }

  void _saveTastingNoteDetails(String label, TastingNoteDetails details) {
    setState(() {
      tastingNote.notes[label] = details;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리뷰 작성하기'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('위스키 리뷰 검색 버튼');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Whiskey name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: TextField(
                    controller: _wbCodeController,
                    decoration: const InputDecoration(
                      labelText: 'WB code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    controller: _abvController,
                    decoration: const InputDecoration(
                      labelText: 'ABV',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ],
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            tabs: const [
              Tab(text: 'Nose'),
              Tab(text: 'Palate'),
              Tab(text: 'Finish'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                TastingNoteInput(
                  label: 'Nose',
                  predefinedElements: {
                    '이탄(피트)': [
                      '요오드',
                      '병원 소독약',
                      '스모키',
                      '생선',
                      '해초',
                      '해산물',
                      '바다짠내',
                      '젖은 흙',
                      '이끼'
                    ],
                    '과일': [
                      '라임',
                      '레몬',
                      '자몽',
                      '귤',
                      '오렌지',
                      '오렌지 껍질',
                      '구아바',
                      '멜론',
                      '망고',
                      '바나나',
                      '파일이플',
                      '패션후르츠',
                      '코코넛',
                      '라치',
                      '모과',
                      '사과',
                      '풋사과',
                      '배',
                      '복숭아',
                      '체리',
                      '자두',
                      '건살구',
                      '매실',
                      '대추야자',
                      '건포도',
                      '블루베리',
                      '청포도',
                      '적포도',
                      '건무화과',
                      '쥬니퍼베리',
                      '딸기'
                    ],
                    '유제품': ['치즈', '우유', '요거트', '그릭요거트', '캐러멜', '버터스카치'],
                    '식물': [
                      '꽃',
                      '장미',
                      '라일락',
                      '헤더',
                      '풀',
                      '잔디',
                      '녹즙기',
                      '건초',
                      '허브',
                      '바질',
                      '민트',
                      '로즈마리',
                      '당류',
                      '설탕',
                      '흑설탕',
                      '메이플시럽',
                      '심플 시럽',
                      '나무',
                      '마른 나무',
                      '젖은 나무',
                      '썩은 나무',
                      '원목 가구',
                      '곡물',
                      '쌀',
                      '밀가루',
                      '감자',
                      '엿기름',
                      '옥수수',
                      '쿠키',
                      '식빵',
                      '식빵 테두리',
                      '볶은 곡물',
                      '보리차',
                      '호밀빵',
                      '견과류',
                      '땅콩',
                      '아몬드',
                      '피스타치오',
                      '호두',
                      '헤이즐넛',
                      '캐슈넛',
                      '육두구',
                      '밀크초콜렛',
                      '다크초콜렛',
                      '커피',
                      '담배',
                      '홍차',
                      '나뭇잎',
                      '꿀',
                      '솔 향',
                      '감초'
                    ],
                    '향신료': ['정향', '바닐라', '계피', '아니스', '후추', '바질', '시나몬'],
                    '기타': [
                      '왁스',
                      '밀랍',
                      '가솔린',
                      '고무',
                      '가죽',
                      '타르 ',
                      '마른 흙',
                      '유기용매',
                      '운동장 먼지',
                      '아세톤',
                      '암모니아',
                      '황',
                      '금속향',
                      '미네랄',
                      '연필심',
                      '석탄'
                    ],
                  },
                  onSave: (details) => _saveTastingNoteDetails('Nose', details),
                ),
                TastingNoteInput(
                  label: 'Plate',
                  predefinedElements: {
                    '이탄(피트)': [
                      '요오드',
                      '병원 소독약',
                      '스모키',
                      '생선',
                      '해초',
                      '해산물',
                      '바다짠내',
                      '젖은 흙',
                      '이끼'
                    ],
                    '과일': [
                      '라임',
                      '레몬',
                      '자몽',
                      '귤',
                      '오렌지',
                      '오렌지 껍질',
                      '구아바',
                      '멜론',
                      '망고',
                      '바나나',
                      '파일이플',
                      '패션후르츠',
                      '코코넛',
                      '라치',
                      '모과',
                      '사과',
                      '풋사과',
                      '배',
                      '복숭아',
                      '체리',
                      '자두',
                      '건살구',
                      '매실',
                      '대추야자',
                      '건포도',
                      '블루베리',
                      '청포도',
                      '적포도',
                      '건무화과',
                      '쥬니퍼베리',
                      '딸기'
                    ],
                    '유제품': ['치즈', '우유', '요거트', '그릭요거트', '캐러멜', '버터스카치'],
                    '식물': [
                      '꽃',
                      '장미',
                      '라일락',
                      '헤더',
                      '풀',
                      '잔디',
                      '녹즙기',
                      '건초',
                      '허브',
                      '바질',
                      '민트',
                      '로즈마리',
                      '당류',
                      '설탕',
                      '흑설탕',
                      '메이플시럽',
                      '심플 시럽',
                      '나무',
                      '마른 나무',
                      '젖은 나무',
                      '썩은 나무',
                      '원목 가구',
                      '곡물',
                      '쌀',
                      '밀가루',
                      '감자',
                      '엿기름',
                      '옥수수',
                      '쿠키',
                      '식빵',
                      '식빵 테두리',
                      '볶은 곡물',
                      '보리차',
                      '호밀빵',
                      '견과류',
                      '땅콩',
                      '아몬드',
                      '피스타치오',
                      '호두',
                      '헤이즐넛',
                      '캐슈넛',
                      '육두구',
                      '밀크초콜렛',
                      '다크초콜렛',
                      '커피',
                      '담배',
                      '홍차',
                      '나뭇잎',
                      '꿀',
                      '솔 향',
                      '감초'
                    ],
                    '향신료': ['정향', '바닐라', '계피', '아니스', '후추', '바질', '시나몬'],
                    '기타': [
                      '왁스',
                      '밀랍',
                      '가솔린',
                      '고무',
                      '가죽',
                      '타르 ',
                      '마른 흙',
                      '유기용매',
                      '운동장 먼지',
                      '아세톤',
                      '암모니아',
                      '황',
                      '금속향',
                      '미네랄',
                      '연필심',
                      '석탄'
                    ],
                  },
                  onSave: (details) =>
                      _saveTastingNoteDetails('Plate', details),
                ),
                TastingNoteInput(
                  label: 'Finish',
                  predefinedElements: {
                    '이탄(피트)': [
                      '요오드',
                      '병원 소독약',
                      '스모키',
                      '생선',
                      '해초',
                      '해산물',
                      '바다짠내',
                      '젖은 흙',
                      '이끼'
                    ],
                    '과일': [
                      '라임',
                      '레몬',
                      '자몽',
                      '귤',
                      '오렌지',
                      '오렌지 껍질',
                      '구아바',
                      '멜론',
                      '망고',
                      '바나나',
                      '파일이플',
                      '패션후르츠',
                      '코코넛',
                      '라치',
                      '모과',
                      '사과',
                      '풋사과',
                      '배',
                      '복숭아',
                      '체리',
                      '자두',
                      '건살구',
                      '매실',
                      '대추야자',
                      '건포도',
                      '블루베리',
                      '청포도',
                      '적포도',
                      '건무화과',
                      '쥬니퍼베리',
                      '딸기'
                    ],
                    '유제품': ['치즈', '우유', '요거트', '그릭요거트', '캐러멜', '버터스카치'],
                    '식물': [
                      '꽃',
                      '장미',
                      '라일락',
                      '헤더',
                      '풀',
                      '잔디',
                      '녹즙기',
                      '건초',
                      '허브',
                      '바질',
                      '민트',
                      '로즈마리',
                      '당류',
                      '설탕',
                      '흑설탕',
                      '메이플시럽',
                      '심플 시럽',
                      '나무',
                      '마른 나무',
                      '젖은 나무',
                      '썩은 나무',
                      '원목 가구',
                      '곡물',
                      '쌀',
                      '밀가루',
                      '감자',
                      '엿기름',
                      '옥수수',
                      '쿠키',
                      '식빵',
                      '식빵 테두리',
                      '볶은 곡물',
                      '보리차',
                      '호밀빵',
                      '견과류',
                      '땅콩',
                      '아몬드',
                      '피스타치오',
                      '호두',
                      '헤이즐넛',
                      '캐슈넛',
                      '육두구',
                      '밀크초콜렛',
                      '다크초콜렛',
                      '커피',
                      '담배',
                      '홍차',
                      '나뭇잎',
                      '꿀',
                      '솔 향',
                      '감초'
                    ],
                    '향신료': ['정향', '바닐라', '계피', '아니스', '후추', '바질', '시나몬'],
                    '기타': [
                      '왁스',
                      '밀랍',
                      '가솔린',
                      '고무',
                      '가죽',
                      '타르 ',
                      '마른 흙',
                      '유기용매',
                      '운동장 먼지',
                      '아세톤',
                      '암모니아',
                      '황',
                      '금속향',
                      '미네랄',
                      '연필심',
                      '석탄'
                    ],
                  },
                  onSave: (details) =>
                      _saveTastingNoteDetails('Finish', details),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _saveWhiskeyData,
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }
}
