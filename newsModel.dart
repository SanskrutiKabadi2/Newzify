import 'package:intl/intl.dart';

class NewsModel {
  final String title;
  final String description;
  final String imageUrl;
  final String author;
  final String publishedAt;
  final String content;
   bool isLiked;
   bool isSaved;

  NewsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.author,
    required this.publishedAt,
    required this.content,
    this.isLiked = false,
    this.isSaved = false,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    String rawDate = json['publishedAt'] ?? '';
  String formattedDate = '';
  if (rawDate.isNotEmpty) {
    try {
      DateTime parsedDate = DateTime.parse(rawDate);
      formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      formattedDate = rawDate; // fallback to raw if parsing fails
    }
  }
  String rawContent = json['content'] ?? '';
  String cleanedContent = '';

  if (rawContent.isNotEmpty) {
    try {
      // Split by sentence-ending punctuation
      List<String> sentences = rawContent.split(RegExp(r'(?<=[.!?])\s+'));

      // Remove sentences that contain ellipses
      cleanedContent = sentences
          .where((s) => !s.contains('...') && !s.contains('…') && !s.contains('[+'))
          .join(' ');
    } catch (e) {
      cleanedContent = rawContent;
    }
  }
    return NewsModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['urlToImage'] ?? '',
      author: json['author'] ?? 'Unknown',
      publishedAt: formattedDate,
      content: cleanedContent,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'urlToImage': imageUrl,
      'author': author,
      'publishedAt': publishedAt,
      'content': content,
      'isLiked': isLiked,
      'isSaved': isSaved,
    };
  }
}

