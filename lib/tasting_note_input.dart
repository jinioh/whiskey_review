import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/tasting_note_detail.dart';

class TastingNoteInput extends StatefulWidget {
  final String label;
  final Map<String, List<String>> predefinedElements;
  final Function(TastingNoteDetails) onSave;

  const TastingNoteInput({
    Key? key,
    required this.label,
    required this.predefinedElements,
    required this.onSave,
  }) : super(key: key);

  @override
  _TastingNoteInputState createState() => _TastingNoteInputState();
}

class _TastingNoteInputState extends State<TastingNoteInput> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  Set<String> _selectedElements = Set();

  void _saveTastingNote() {
    final tastingNote = TastingNoteDetails(
      totalScore: int.tryParse(_scoreController.text) ?? 0,
      elements: _selectedElements,
      comment: _commentController.text,
    );
    widget.onSave(tastingNote);
  }

  void _showErrorMessage() {
    const snackBar = SnackBar(
      content: Text('최대 8개까지 선택할 수 있습니다.'),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showChipsDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('요소를 선택해주세요'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ...widget.predefinedElements.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                          child: Text(entry.key,
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: entry.value.map((element) {
                            bool isSelected =
                                _selectedElements.contains(element);
                            return ChoiceChip(
                              label: Text(element),
                              selected: isSelected,
                              selectedColor: Colors.brown,
                              onSelected: (bool selected) {
                                if (selected) {
                                  if (_selectedElements.length > 8) {
                                    _showErrorMessage();
                                  } else {
                                    setState(() {
                                      _selectedElements.add(element);
                                    });
                                  }
                                } else {
                                  setState(() {
                                    _selectedElements.remove(element);
                                  });
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('닫기'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _selectedElements = Set<String>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addElement() {
    String newElement = _controller.text.trim();

    if (newElement.isNotEmpty && !_selectedElements.contains(newElement)) {
      if (_selectedElements.length >= 8) {
        _showErrorMessage();
      } else {
        setState(() {
          _selectedElements.add(newElement);
          _controller.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> chipsGroups = widget.predefinedElements.entries.map((entry) {
      List<Widget> chips = entry.value.map((element) {
        bool isSelected = _selectedElements.contains(element);
        return ChoiceChip(
            label: Text(element),
            selected: isSelected,
            selectedColor: Colors.brown,
            onSelected: (bool selected) {
              if (selected) {
                if (_selectedElements.length >= 8) {
                  _showErrorMessage();
                } else {
                  setState(() {
                    _selectedElements.add(element);
                  });
                }
              } else {
                setState(() {
                  _selectedElements.remove(element);
                });
              }
            });
      }).toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child:
                Text(entry.key, style: Theme.of(context).textTheme.subtitle1),
          ),
          Wrap(
            spacing: 8.0,
            children: chips,
          ),
        ],
      );
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _scoreController,
            decoration: const InputDecoration(
              labelText: 'Total Score(1~100)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Add Element',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: _addElement,
                child: Text('Add'),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: _showChipsDialog,
          child: const Text('전체보기'),
        ),
        if (_selectedElements.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '선택된 요소 ${_selectedElements.length}개',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        Container(
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...chipsGroups,
                // if (_selectedElements.length >= 8)
                //   const Padding(
                //     padding: EdgeInsets.all(8.0),
                //     child: Text(
                //       '최대 8개까지만 선택할 수 있습니다.',
                //       style: TextStyle(
                //           color: Colors.red, fontWeight: FontWeight.bold),
                //     ),
                //   )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _commentController,
            decoration: const InputDecoration(
              labelText: 'Comment',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 5,
          ),
        ),
      ],
    );
  }
}
