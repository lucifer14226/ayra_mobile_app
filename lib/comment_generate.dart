import 'package:flutter/material.dart';
import 'package:rating_and_comment/ReviewBox.dart';
import 'package:rating_and_comment/coment_data.dart';

class CommentGenerate extends StatefulWidget {
  const CommentGenerate({super.key});

  @override
  State<CommentGenerate> createState() => _CommentGenerateState();
}

class _CommentGenerateState extends State<CommentGenerate> {
  List _comment = comment;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          height: 150,
          margin: const EdgeInsets.all(10),
          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: ReviewBox(comment: _comment[index]),
        );
      },
      itemCount: _comment.length,
    );
  }
}
