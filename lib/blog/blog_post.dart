import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../constanst.dart';

class BlogPost extends StatelessWidget {
  final String title;
  final String mainText;
  final String date;
  final String comments;
  final String imageUrl;

  const BlogPost({
    super.key, required this.title, required this.mainText, required this.date, required this.comments, required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        //height: 600,
        //color: Colors.red,
        child: Column(
          children: [
            Container(
              color: Colors.lightBlue[50],
              child: CachedNetworkImage(height: 300,width: 300, imageUrl: imageUrl,
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 18,),
                  const SizedBox(width: 4),
                  Text(date),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      const Icon(Icons.comment, size: 18,),
                      const SizedBox(width: 4),
                      Text(comments)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  HtmlWidget(title),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                children: [
                  HtmlWidget(mainText,
                    //style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}