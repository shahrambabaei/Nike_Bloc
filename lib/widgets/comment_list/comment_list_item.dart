
import 'package:flutter/material.dart';
import 'package:nike/data/models/comment.dart';

class CommentListItem extends StatelessWidget {
  const CommentListItem({Key? key, required this.commentEntinty})
      : super(key: key);
  final CommentEntinty commentEntinty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
          borderRadius: BorderRadius.circular(4)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(commentEntinty.title),
                const SizedBox(height: 4),
                Text(commentEntinty.email,
                    style: Theme.of(context).textTheme.caption)
              ],
            ),
            Text(commentEntinty.date,
                style: Theme.of(context).textTheme.caption)
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Text(commentEntinty.content,style: const TextStyle(height: 1.4),)
      ]),
    );
  }
}
