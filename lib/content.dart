import 'package:flutter/material.dart';
import 'package:newsapp/webview.dart';

class Content extends StatelessWidget {
  Content(
    this.name,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
  );
  final String name;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.0),
      child: SingleChildScrollView(
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Webview(
                title: name,
                selectedUrl: url,
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(10),
          enableFeedback: true,
          splashColor: Colors.blue,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    constraints: BoxConstraints(maxHeight: 150),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      child: urlToImage != null
                          ? FadeInImage(
                              placeholder:
                                  AssetImage('images/imagePlaceholder.png'),
                              image: NetworkImage(
                                urlToImage,
                              ),
                              fit: BoxFit.cover,
                              height: 200,
                            )
                          : Center(
                              child: Text(
                                'Image not available!',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 3, left: 8, right: 8),
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                    child: Text(title != null ? title : '[title]',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8, bottom: 3),
                    child: Text(
                        description != null ? description : '[description]',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 2),
                    child: Text(
                      '${publishedAt.substring(11, 16)}',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8, bottom: 2),
                        child: Text(
                          '${publishedAt.substring(0, 10)}',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Spacer(),
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.5),
                        padding: EdgeInsets.only(left: 8, bottom: 2, right: 8),
                        child: Text(
                          author != null ? author : '~unknown',
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
