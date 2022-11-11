import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

List<String> Notes = [];

//final _storage = SharedPreferences.getInstance();

class NoteWidget extends StatefulWidget {
  const NoteWidget({
    super.key,
  });

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  bool isActiveButton = false;
  late TextEditingController textNoteController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    textNoteController = TextEditingController();
    textNoteController.addListener(() {
      final isActiveButton = textNoteController.text.isNotEmpty;

      setState(() => this.isActiveButton = isActiveButton);
    });
  }

  @override
  void dispose() {
    textNoteController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 43, 42, 44),
            ),
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height / 3.33,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: textNoteController,
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                        hintText: ' Enter text',
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                    maxLines: 4,
                    maxLength: 160,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: isActiveButton
                          ? () {
                              setState(() => isActiveButton = false);

                              Notes.add(textNoteController.text);

                              textNoteController.clear();
                            }
                          : null,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 27, 26, 26),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: isActiveButton
                              ? const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 10, 147, 65),
                                    offset: Offset(
                                      2.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Color.fromARGB(255, 15, 109, 34),
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ]
                              : null,
                        ),
                        height: MediaQuery.of(context).size.height / 14,
                        width: MediaQuery.of(context).size.height / 14,
                        child: Icon(
                          Icons.check,
                          size: 30,
                          color: isActiveButton
                              ? Colors.green
                              : Color.fromARGB(255, 62, 61, 61),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: SingleChildScrollView(
                child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: Notes.length,
                  itemBuilder: (context, int index) {
                    return Dismissible(
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        setState(() {
                          Notes.removeAt(index);
                        });
                      },
                      key: ValueKey<int>(Notes.length),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 43, 42, 44),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(242, 42, 43, 42),
                                offset: Offset(
                                  1.0,
                                  1.0,
                                ),
                                blurRadius: 7.0,
                                spreadRadius: 0.0,
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            Notes[index],
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  }),
            )),
          ),
        ],
      ),
    );
  }
}
