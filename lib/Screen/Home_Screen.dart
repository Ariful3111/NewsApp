import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_apps/Model/ArticleModel.dart';
import 'package:http/http.dart' as http;
import 'package:news_apps/Screen/AllNews.dart';
import 'package:news_apps/Screen/BreakingNews.dart';
import 'package:news_apps/Screen/Search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text('365 News '),
          actions: [IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Search()));
          },
              icon: Icon(Icons.search))],
          centerTitle: true,
          bottom: TabBar(tabs:[
            Tab(text: 'Breaking',),
            Tab(text: 'All News',),
          ],),
        ),
        body: TabBarView(
          children: [
            Breaking(),
            AllNews(),
          ],
        ),
      ),
    );
  }
}
