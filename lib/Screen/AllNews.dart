import 'package:flutter/material.dart';
import 'package:news_apps/Api/ApiService.dart';
import 'package:news_apps/Components/Newsitemlist.dart';
import 'package:news_apps/Model/NewsModel.dart';

class AllNews extends StatefulWidget {
  const AllNews({Key? key}) : super(key: key);

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  ApiService apiService = ApiService();
  int pageNo=1;
String  sortBy= 'publishedAt';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if(pageNo>1){
                        pageNo--;
                      }
                    });
                  },
                  child: Text('Prev'),
                ),
                ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            pageNo=index+1;
                          });
                        },
                        child: Container(
                          color:pageNo==index+1? Colors.blue:Colors.white,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(12),
                          child: Text('${index+1}'),
                        ),
                      );
                    }),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if(pageNo<5){
                        pageNo++;
                      }
                    });
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: DropdownButton(
              value: sortBy,
                items: [
                  DropdownMenuItem(child: Text('publishedAt'), value: 'publishedAt',),
                  DropdownMenuItem(child: Text('popularity'), value: 'popularity',),
                  DropdownMenuItem(child: Text('relevancy'), value: 'relevancy',),
                ],
                onChanged: (value){
                setState(() {
                  sortBy=value!;
                });
                }
            ),
          ),
          Expanded(

            child: FutureBuilder(
                future: apiService.getallNews(pageNo, sortBy),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ArticleModel> articlelist = snapshot.data ?? [];
                    return ListView.builder(
                        itemCount: articlelist.length,
                        itemBuilder: (context, index) {
                          return NewsItemList(
                            articleModel: articlelist[index],
                          );
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ),
        ],
      ),
    );
  }
}
