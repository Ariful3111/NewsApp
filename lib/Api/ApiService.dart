import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_apps/Model/ArticleModel.dart';

class ApiService{

  Future<List<ArticleModel>> getallNews([int ? pageNo, String ? sortBy])async{
   ArticleModel ? articleModel;
    String AllNewsurl='https://newsapi.org/v2/everything?q=football&sortBy=$sortBy&pagesize=10&page=$pageNo&apiKey=0835f74d5c194d7bbf53892f31d5562f';

  try{
      Response response = await get(Uri.parse(AllNewsurl));
      if(response.statusCode==200){
        Map<String,dynamic> json=jsonDecode(response.body);
        List<dynamic> body=json['articles'];
        List<ArticleModel> articles=body.map((item) => ArticleModel.fromJson(item)).toList();
        return articles;
      }else{
        throw('No Data Found');
      }
    }catch(e){
      throw e;
    }
  }
Future<List<ArticleModel>> getbreakingNews([int ? pageNo])async{
    String BreakingNewsurl='https://newsapi.org/v2/top-headlines?country=us&pagesize=10&page=${pageNo}&apiKey=0835f74d5c194d7bbf53892f31d5562f';

    try{
      Response response = await get(Uri.parse(BreakingNewsurl));
      if(response.statusCode==200){
        Map<String,dynamic> json=jsonDecode(response.body);
        List<dynamic> body=json['articles'];
        List<ArticleModel> articles=body.map((item) => ArticleModel.fromJson(item)).toList();
        return articles;
      }else{
        throw('No Data Found');
      }
    }catch(e){
      print(e.toString());
      throw e;
    }
  }
 static Future<List<ArticleModel>> searchdata(String ? search)async{
   ArticleModel ? articleModel;
   String searchdataurl='https://newsapi.org/v2/everything?q=football&sortBy=publishedAte&pagesize=10&page=1&apiKey=0835f74d5c194d7bbf53892f31d5562f';

   try{
     Response response = await get(Uri.parse(searchdataurl));
     if(response.statusCode==200){
       Map<String,dynamic> json=jsonDecode(response.body);
       List<dynamic> body=json['articles'];
       List<ArticleModel> articles=body.map((item) => ArticleModel.fromJson(item)).toList();
       return articles;
     }else{
       throw('No Data Found');
     }
   }catch(e){
     throw e;
   }
 }


}