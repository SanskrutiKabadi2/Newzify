import 'package:flutter/material.dart';

class HomeNewsTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String content;
  final String description;
  final String author;
  final String time;
  final bool isLiked;
  final bool isSaved;

  //final VoidCallback ontap;

  const HomeNewsTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.content,
      required this.time,
      required this.author,
      required this.isLiked,
      required this.isSaved
     
     });

      
  @override
  Widget build(BuildContext context) {
    return Container(
                          padding: const EdgeInsets.all(10),
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  imageUrl,
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontFamily: 'play',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 10,
                                          backgroundImage:AssetImage("Assets/ss.jpg")
                                        ),
                                        const SizedBox(width: 5),
                                         Expanded(
                                          child: Text(
                                            author,
                                            style: TextStyle(color: Colors.black54),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(time, style: TextStyle(color: Colors.black54),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
    );
  }
}
                      
            
      
 
