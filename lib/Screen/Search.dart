import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:news_apps/Api/ApiService.dart';
import 'package:news_apps/Model/ArticleModel.dart';
import 'package:news_apps/Model/NewsModel.dart';
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  NewsModel  newsModel=NewsModel();
  ArticleModel ? articleModel;
  TextEditingController searchcontroller = TextEditingController();
  List<String> suggentionList=[
    'Sports',
    'Technology',
    'Politicise',
    'Hospital',
    'Medical',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search what you are interested'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: searchcontroller,
                onEditingComplete: ()async{
                  newsModel = (await ApiService.searchdata(searchcontroller.text)) as NewsModel;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  suffix: IconButton(onPressed: (){
                    searchcontroller.clear();
                   newsModel.articles!.clear();
                    setState(() {

                    });
                  }, icon: Icon(Icons.cancel_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              MasonryGridView.count(
                shrinkWrap: true,
                  itemCount: suggentionList.length,
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemBuilder: (context, index){
                    return InkWell(
                        onTap: ()async{
                          searchcontroller.text=suggentionList[index];
                          newsModel = ((await ApiService.searchdata(suggentionList[index])) as NewsModel?)!;
                          setState(() {

                          });
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue,)
                          ),
                          child: Center(child: Text('${suggentionList[index]}')),
                        ));
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

