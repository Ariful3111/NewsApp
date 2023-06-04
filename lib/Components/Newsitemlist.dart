import 'package:flutter/material.dart';
import 'package:news_apps/Model/ArticleModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_apps/Screen/NewsDetails.dart';

class NewsItemList extends StatefulWidget {
  final ArticleModel articleModel;
  const NewsItemList({
    Key? key,
    required this.articleModel,
  }) : super(key: key);

  @override
  State<NewsItemList> createState() => _NewsItemListState();
}

class _NewsItemListState extends State<NewsItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NewsDetails(articleModel: widget.articleModel)));
            },
            child: CachedNetworkImage(
              imageUrl: widget.articleModel.urlToImage.toString(),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Container(
                  height: 300,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Icon(
                    Icons.error,
                    size: 50,
                  ))),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(widget.articleModel.source!.name.toString())),
              SizedBox(
                width: 8,
              ),
              Text(widget.articleModel.publishedAt.toString()),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(widget.articleModel.author == null
              ? ''
              : 'Written By' + widget.articleModel.author.toString()),
          Text(widget.articleModel.title.toString()),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
