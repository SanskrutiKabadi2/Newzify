import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/details.dart';
import 'package:untitled/listTileHome.dart';
import 'Controller/newscontroller.dart';



class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final List<String> categories = ["all","sports", "politics","technology","business"];
  TextEditingController search = TextEditingController();
  bool isLoading = false;
  String selectedCategory = "All";
  
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap:(){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,),
          )
         ,
SizedBox(
  height: 2,

),
         
          Text(
                "Discover",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,color: Colors.black,
                ),
              ),
             // SizedBox(height: 2,),
          Text(
            "News from all around the world!",
            style: TextStyle(color: const Color.fromARGB(255, 12, 9, 9),fontFamily: 'play'),
          ),
          SizedBox(height: 20),
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 5),
                    child: TextField(
                      controller: search,
                      decoration: InputDecoration(
                        hintText: "Search news ...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 45,
                    height: 45,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Obx(() => newsController.isSearching.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Icon(Icons.search, color: Colors.white)),
                    ),
                  ),
                  onTap: () {
                   
                    if (search.text.trim().isNotEmpty) {
                      newsController.searchNews(search.text.trim());
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
  padding: const EdgeInsets.only(right: 10.0),
  child: Obx(() => GestureDetector(
    onTap: () {
      newsController.updateDisplayedNews(index, categories[index]);
    },
    child: Container(
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: newsController.isSelected[index] ? Colors.blue : Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          categories[index],
          style: TextStyle(
            color: newsController.isSelected[index] ? Colors.white : Colors.blue,
          ),
        ),
      ),
    ),
  )),
);
              },
            ),
          ),
          SizedBox(height: 20),
          Obx(() {
            
            
              var newslist=newsController.selectedCategory;
              return ListView.builder(
                  
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: newslist.length,
                itemBuilder: (context, index) {
                 var article = newslist[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        newsController.setSelectedArticle(article); // where 'news' is NewsModel
                          Get.to(() => ArticleScreen());
                      },
                      child: HomeNewsTile(
                        imageUrl: article.imageUrl,
                        title: article.title,
                        description: article.description,
                        content: article.content,
                        author: article.author,
                        time: article.publishedAt,
                        isLiked: false,
                        isSaved: false,
                      ),
                    ),
                  );
                },
              );
            }
          ),
        ],
      
    ),
  ),
),

      
     
      // return ListView.builder(
      //   itemCount: newsController.searchNewsList.length,
      //   physics: const BouncingScrollPhysics(),
      //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //   itemBuilder: (context, index) {
      //     var article = newsController.searchNewsList[index];
      //     return Padding(
      //       padding: const EdgeInsets.only(bottom: 12),
      //       child: GestureDetector(
      //         onTap: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(builder: (context) => ArticleScreen()),
      //           );
      //         },
      //         child: Container(
      //           padding: const EdgeInsets.all(10),
      //           height: 110,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(15),
      //             color: Colors.white,
      //             boxShadow: [
      //               BoxShadow(
      //                 color: Colors.black.withOpacity(0.1),
      //                 blurRadius: 5,
      //                 spreadRadius: 1,
      //                 offset: const Offset(0, 3),
      //               ),
      //             ],
      //           ),
      //           child: Row(
      //             children: [
      //               ClipRRect(
      //                 borderRadius: BorderRadius.circular(15),
      //                 child: Image.network(
      //                   article.imageUrl ?? 'https://via.placeholder.com/150',
      //                   height: 90,
      //                   width: 90,
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //               const SizedBox(width: 10),
      //               Expanded(
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       article.title ?? 'No title available',
      //                       maxLines: 2,
      //                       overflow: TextOverflow.ellipsis,
      //                       style: const TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         color: Colors.black87,
      //                       ),
      //                     ),
      //                     const SizedBox(height: 5),
      //                     Row(
      //                       children: [
      //                         const CircleAvatar(
      //                           radius: 10,
      //                           backgroundColor: Color.fromARGB(255, 95, 141, 179),
      //                         ),
      //                         const SizedBox(width: 5),
      //                         Expanded(
      //                           child: Text(
      //                             article.author ?? 'Unknown source',
      //                             style: const TextStyle(color: Colors.black54),
      //                             overflow: TextOverflow.ellipsis,
      //                           ),
      //                         ),
      //                         IconButton(
      //                           icon: const Icon(
      //                             Icons.bookmark,
      //                             color: Color.fromARGB(255, 217, 203, 71),
      //                             size: 28,
      //                           ),
      //                           onPressed: () {
      //                             // Bookmark toggle logic
      //                           },
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // );
  
  
  
         
    ),
    );
    
  }
}



//                 Expanded(
//   child: Obx(() {
//     if (newsController.searchNewsList.isEmpty) {
//       return Center(
//         child: Text(
//           "Search for news...",
//           style: TextStyle(
//             fontSize: 18,
//             color: Colors.grey,
//           ),
//         ),
//       );
//     } else {
//       return ListView.builder(
//         itemCount: newsController.searchNewsList.length,
//         physics: const BouncingScrollPhysics(),
//         itemBuilder: (context, index) {
//           var article = newsController.searchNewsList[index];
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               height: 110,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 5,
//                     spreadRadius: 1,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Image.network(
//                       article.imageUrl ?? 'https://via.placeholder.com/150',
//                       height: 90,
//                       width: 90,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           article.title ?? 'No title available',
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           children: [
//                             const CircleAvatar(
//                               radius: 10,
//                               backgroundColor: Color.fromARGB(255, 95, 141, 179),
//                             ),
//                             const SizedBox(width: 5),
//                             Expanded(
//                               child: Text(
//                                 article.author ?? 'Unknown source',
//                                 style: TextStyle(color: Colors.black54),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             IconButton(
//                               icon: Icon(
//                                 Icons.bookmark,
//                                 color: Color.fromARGB(255, 217, 203, 71),
//                                 size: 28,
//                               ),
//                               onPressed: () {
//                                 // Bookmark toggle logic
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     }
//   }),
// )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
