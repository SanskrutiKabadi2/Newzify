import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Controller/newscontroller.dart';
import 'package:untitled/Models/newsModel.dart';

class SavedNews extends StatelessWidget {
  SavedNews({super.key});
  final NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 28,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "My Saved News",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 95, 141, 179),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  if (controller.savedArticles.isEmpty) {
                    return const Center(
                      child: Text(
                        "No news are saved.",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: controller.savedArticles.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final news = controller.savedArticles[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
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
                                  news.imageUrl ??
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-joDW80HIi7WIer3DwtsU99R_vOZBZBYfWg&s",
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
                                        news.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
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
                                          backgroundImage: AssetImage("Assets/ss.jpg")
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            news.author ?? "Unknown",
                                            style: const TextStyle(color: Colors.black54),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.saveNews(news);
                                          },
                                          child: Icon(
                                            news.isSaved ? Icons.bookmark : Icons.bookmark_border,
                                            color: news.isSaved ? const Color.fromRGBO(224, 202, 135, 1) : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
