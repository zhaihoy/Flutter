import 'package:flutter/material.dart';

import '../bean/PageResponseData.dart';

class ProjectArticleCardItem extends StatefulWidget {
  Article chapter;

  @override
  State<StatefulWidget> createState() {
    return ProjectArticleCardStatefulWidget();
  }

  ProjectArticleCardItem(this.chapter);
}

class ProjectArticleCardStatefulWidget extends State<ProjectArticleCardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1.0),
      ),
      child: InkWell(
        onTap: () {
// Handle card tap
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.chapter.author,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.chapter.niceDate,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      widget.chapter.title,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.chapter.chapterName,
                      style: const TextStyle(
                        color: Colors.blue, // Replace with your color
                        fontSize: 14.0, // Replace with your size
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                width: 100.0, // Adjust as per your image size
                height: 100.0, // Adjust as per your image size
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.chapter.envelopePic),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust as per your image roundness
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
