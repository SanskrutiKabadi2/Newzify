import 'dart:convert';
import 'package:intl/intl.dart'; 

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Models/newsModel.dart';


class NewsController extends GetxController {
  RxList<NewsModel> allNews = <NewsModel>[].obs;
  RxList<NewsModel> sportsNews = <NewsModel>[].obs;
  RxList<NewsModel> politicsNews = <NewsModel>[].obs;
  RxList<NewsModel> techNews = <NewsModel>[].obs;
  RxList<NewsModel> businessNews = <NewsModel>[].obs;
  RxList<NewsModel> apple5News = <NewsModel>[].obs;
  RxList<NewsModel> teslaNewsList = <NewsModel>[].obs;
  RxList<NewsModel> tesla5News = <NewsModel>[].obs;
  RxList<NewsModel> searchNewsList = <NewsModel>[].obs;
  RxList<NewsModel> business5News = <NewsModel>[].obs;
  RxBool isTrandingLoading = false.obs;
  RxBool isNewsForULoading = false.obs;
  RxBool isTeslaLoading = false.obs;
  RxBool isAppleLoading = false.obs;
  RxBool isBuisLoading = false.obs;
  RxBool isSpeeking = false.obs;
  RxList<NewsModel> selectedCategory = <NewsModel>[].obs;
 RxList<bool> isSelected = <bool>[true, false, false, false, false].obs;
 RxList<NewsModel> savedNewsList = <NewsModel>[].obs;
 RxList<NewsModel> likedNewsList = <NewsModel>[].obs;
 

 
  
 
  FlutterTts flutterTts = FlutterTts();
  RxBool isSearching = false.obs;

 

  void onInit()async{
    super.onInit();
    
   
    await getAllNews();
    await getSportsNews();
   
    await getPoliticsNews();
    await getTechNews();
    await getBusinessNews();
    selectedCategory.assignAll(allNews);
   // getTrandingNews();
    //getAppleNews();
  //  getTeslaNews();
   // getBusinessNews();
    flutterTts.setStartHandler(() {
    isSpeeking.value = true;
  });

  flutterTts.setCompletionHandler(() {
    isSpeeking.value = false;
  });

  flutterTts.setCancelHandler(() {
    isSpeeking.value = false;
  });


   
    
  }
  Rxn<NewsModel> selectedArticle = Rxn<NewsModel>();


void setSelectedArticle(NewsModel article) {
  selectedArticle.value = article;
}
  Future<void> getAllNews() async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String toDate = formatter.format(DateTime.now());
  final String fromDate = formatter.format(DateTime.now().subtract(Duration(days: 2)));
  
    
    var baseURL = "https://newsapi.org/v2/everything?q=all&from=$fromDate&to=$toDate&sortBy=publishedAt&apiKey=b2bf8124f03548418137930fcc3409f5";
    try {
      var response = await http.get(Uri.parse(baseURL));
      print(response);
      if (response.statusCode == 200) {
        print("all");
        print(response.body);
        var body = jsonDecode(response.body);
        var articals = body["articles"];
        for (var news in articals) {
        //   if (news["urlToImage"] != null && news["urlToImage"].toString().isNotEmpty) {
        //     allNews.add(NewsModel.fromJson(news));
        // }
        allNews.add(NewsModel.fromJson(news));
          
        }
      } else {
        print("Something went Wrong in Tranding News");
      }
    } catch (ex) {
      print(ex);
    }
    
  }
  
  Future<void> getSportsNews() async {
    
    var baseURL ="https://newsapi.org/v2/everything?q=sports&sortBy=popularity&apiKey=b2bf8124f03548418137930fcc3409f5";
    try {
      var response = await http.get(Uri.parse(baseURL));
      print(response);
      if (response.statusCode == 200) {
        print("sports");
        print(response.body);
        var body = jsonDecode(response.body);
        var articals = body["articles"];
        for (var news in articals) {
          if (news["urlToImage"] != null && news["urlToImage"].toString().isNotEmpty) {
            sportsNews.add(NewsModel.fromJson(news));
        }
         
        }
      } else {
        print("Something went Wrong in Tranding News");
      }
    } catch (ex) {
      print(ex);
    }
    
  }
  
  Future<void> getTechNews() async {
    
    var baseURL ="https://newsapi.org/v2/everything?q=technology&sortBy=popularity&apiKey=b2bf8124f03548418137930fcc3409f5";
    try {
      var response = await http.get(Uri.parse(baseURL));
      print(response);
      if (response.statusCode == 200) {
        print("tech");
        print(response.body);
        var body = jsonDecode(response.body);
        var articals = body["articles"];
        for (var news in articals) {
          if (news["urlToImage"] != null && news["urlToImage"].toString().isNotEmpty) {
            techNews.add(NewsModel.fromJson(news));
        }
          
        }
      } else {
        print("Something went Wrong in Tranding News");
      }
    } catch (ex) {
      print(ex);
    }
    
  }
  
  Future<void> getPoliticsNews() async {
    
    var baseURL ="https://newsapi.org/v2/everything?q=indian politics&sortBy=popularity&apiKey=b2bf8124f03548418137930fcc3409f5";
    try {
      var response = await http.get(Uri.parse(baseURL));
      print(response);
      if (response.statusCode == 200) {
        print("politics");
        print(response.body);
        var body = jsonDecode(response.body);
        var articals = body["articles"];
        for (var news in articals) {
          if (news["urlToImage"] != null && news["urlToImage"].toString().isNotEmpty) {
            politicsNews.add(NewsModel.fromJson(news));
        }
         
        }
      } else {
        print("Something went Wrong in Tranding News");
      }
    } catch (ex) {
      print(ex);
    }
    
  }
  Future<void> getBusinessNews() async {
    
    var baseURL ="https://newsapi.org/v2/everything?q=business&sortBy=popularity&apiKey=b2bf8124f03548418137930fcc3409f5";
    try {
      var response = await http.get(Uri.parse(baseURL));
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        var body = jsonDecode(response.body);
        var articals = body["articles"];
        for (var news in articals) {
          if (news["urlToImage"] != null && news["urlToImage"].toString().isNotEmpty) {
            businessNews.add(NewsModel.fromJson(news));
        }
         
        }
      } else {
        print("Something went Wrong in Tranding News");
      }
    } catch (ex) {
      print(ex);
    }
    
  }
  RxList savedArticles = <NewsModel>[].obs; // List for saved articles
  RxList likedArticles = <NewsModel>[].obs;  // List for liked articles

  // Method to handle liking an article
  void likeNews(NewsModel article) {
    if (article.isLiked) {
      article.isLiked = false;
      likedArticles.remove(article); // Remove from liked list
    } else {
      article.isLiked = true;
      likedArticles.add(article); // Add to liked list
    }
    selectedArticle.refresh(); // Refresh the selected article to reflect changes
  }

  // Method to handle saving an article
  void saveNews(NewsModel article) {
    if (article.isSaved) {
      article.isSaved = false;
      savedArticles.remove(article); // Remove from saved list
    } else {
      article.isSaved = true;
      savedArticles.add(article); // Add to saved list
    }
   selectedArticle.refresh();// Refresh the selected article to reflect changes
  }

  // Future<void> getNewsForYou() async {
  //   isNewsForULoading.value = true;
  //   var baseURL =
  //       "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=ea97c6bb67b040759084c3c20ea5e5cf";
  //   try {
  //     var response = await http.get(Uri.parse(baseURL));
  //     print(response);
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       var body = jsonDecode(response.body);
  //       var articals = body["articles"];
  //       for (var news in articals) {
  //         newsForYouList.add(NewsModel.fromJson(news));
  //       }
  //       newsForYou5.value = newsForYouList.sublist(0, 5).obs;
  //     } else {
  //       print("Something went Wrong in Tranding News");
  //     }
  //   } catch (ex) {
  //     print(ex);
  //   }
  //   isNewsForULoading.value = false;
  // }


  // Future<void> getTeslaNews() async {
  //   isTeslaLoading.value = true;
  //   var baseURL =
  //       "https://newsapi.org/v2/everything?q=tesla&from=2023-12-22&sortBy=publishedAt&apiKey=ea97c6bb67b040759084c3c20ea5e5cf";
  //   try {
  //     var response = await http.get(Uri.parse(baseURL));
  //     print(response);
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       var body = jsonDecode(response.body);
  //       var articals = body["articles"];
  //       for (var news in articals) {
  //         teslaNewsList.add(NewsModel.fromJson(news));
  //       }
  //       tesla5News.value = teslaNewsList.sublist(0, 5).obs;
  //     } else {
  //       print("Something went Wrong in Tranding News");
  //     }
  //   } catch (ex) {
  //     print(ex);
  //   }
  //   isTeslaLoading.value = false;
  // }

  // Future<void> getBusinessNews() async {
  //   isBuisLoading.value = true;
  //   var baseURL =
  //       "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ea97c6bb67b040759084c3c20ea5e5cf";
  //   try {
  //     var response = await http.get(Uri.parse(baseURL));
  //     print(response);
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       var body = jsonDecode(response.body);
  //       var articals = body["articles"];
  //       for (var news in articals) {
  //         businessNewsList.add(NewsModel.fromJson(news));
  //       }
  //       business5News.value = businessNewsList.sublist(0, 5).obs;
  //     } else {
  //       print("Something went Wrong in Tranding News");
  //     }
  //   } catch (ex) {
  //     print(ex);
  //   }
  //   isBuisLoading.value = false;
  // }

  Future<void> searchNews(String search) async {
    isSearching.value=true;
    var baseURL =
        "https://newsapi.org/v2/everything?q=$search&apiKey=b2bf8124f03548418137930fcc3409f5";
    try {
      var response = await http.get(Uri.parse(baseURL));
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        var body = jsonDecode(response.body);
        var articals = body["articles"];
        searchNewsList.clear();
        int i = 0;
        for (var news in articals) {
          i++;
          searchNewsList.add(NewsModel.fromJson(news));
          if (i == 50) {
            break;
          }
        }
        selectedCategory.assignAll(searchNewsList);
      } else {
        isSearching.value= false;
        print("Something went Wrong in Tranding News");
      }
    } catch (ex) {
      print(ex);
    }
     isSearching.value= false;
  }

  

 void updateDisplayedNews(int index,String tag) {

  for (int i = 0; i < isSelected.length; i++) {
    isSelected[i] = i == index;
  }
  switch (tag.toLowerCase()) {
    case 'sports':
      selectedCategory.assignAll(sportsNews);
      break;
    case 'technology':
      selectedCategory.assignAll(techNews);
      break;
    case 'politics':
      selectedCategory.assignAll(politicsNews);
      break;
    case 'business':
      selectedCategory.assignAll(businessNews);
      break;
    default:
      selectedCategory.assignAll(allNews);
  }
  update(); 
}
 
  Future<void> speak(String text) async {
    isSpeeking.value = true;
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
    isSpeeking.value = false;
  }
   Future<void> stop() async {
  await flutterTts.stop();
  isSpeeking.value = false;
}


 
}
