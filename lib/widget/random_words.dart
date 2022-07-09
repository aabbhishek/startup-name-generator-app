import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  final Set<WordPair> saved;
  final TextStyle biggerFont;
  const RandomWords({Key? key, required this.saved, required this.biggerFont})
      : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        final alreadySaved = widget.saved.contains(_suggestions[index]); // NEW

        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: widget.biggerFont,
          ),
          trailing: Icon(
            // NEW from here ...
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
            semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
          ),
          onTap: () {
            setState(() {
              if (alreadySaved) {
                widget.saved.remove(_suggestions[index]);
              } else {
                widget.saved.add(_suggestions[index]);
              }
            });
          },
        );
      },
    );
  }
}
