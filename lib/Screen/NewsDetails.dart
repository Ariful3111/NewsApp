import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_apps/Model/ArticleModel.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatefulWidget {
 final ArticleModel articleModel;
  const NewsDetails({Key? key,required this.articleModel}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.articleModel.title.toString()),
      ),
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl:widget.articleModel.urlToImage.toString(),
            placeholder: (context, url)=>CircularProgressIndicator(),
            errorWidget: (context, url, error)=>Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: Icon(Icons.error,size: 50,))),
          ),
          SizedBox(height: 8,),
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
              SizedBox(width: 8,),
              Text(widget.articleModel.publishedAt.toString()),
            ],
          ),
          SizedBox(height: 8,),
          Text(widget.articleModel.author==null?'' : 'Written By' + widget.articleModel.author.toString()),
          Text(widget.articleModel.title.toString()),
          SizedBox(height: 20,),
          Text(widget.articleModel.description.toString()),
          SizedBox(height: 20,),

          ElevatedButton(onPressed: ()async{
            final Uri uri= Uri.parse(widget.articleModel.url.toString());
            if(!await launchUrl(uri)){
              throw Exception('Could Not Launch');
            }
          },
              child: Text('Read More....')),
        ],
      ),
    );
  }
}
