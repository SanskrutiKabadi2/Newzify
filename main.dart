import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/aboutUs.dart';
import 'package:untitled/apidata.dart';
import 'package:untitled/drawer.dart';
import 'package:untitled/home.dart';
import 'package:untitled/splash.dart';
import 'package:untitled/ss.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}



// Initialize GetStorage for persistent state
// void main() async {
//   await GetStorage.init();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "News App",
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       themeMode: ThemeMode.system,
//       home:SavedNews(),
//     );
//   }
// }

// // Controller for managing article state
// class ArticleController extends GetxController {
//   var isLiked = false.obs;
//   var isSaved = false.obs;
//   var isPlaying = false.obs;
//   final FlutterTts flutterTts = FlutterTts();
//   final box = GetStorage(); // Local storage

//   @override
//   void onInit() {
//     super.onInit();
//     isLiked.value = box.read("isLiked") ?? false;
//     isSaved.value = box.read("isSaved") ?? false;
//   }

//   Future<void> speak() async {
//     isPlaying.value = true;
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setPitch(1.0);
//     await flutterTts.speak("This is a sample news article being read aloud...");
//     flutterTts.setCompletionHandler(() {
//       isPlaying.value = false;
//     });
//   }

//   Future<void> stopSpeaking() async {
//     await flutterTts.stop();
//     isPlaying.value = false;
//   }

//   void toggleLike() {
//     isLiked.value = !isLiked.value;
//     box.write("isLiked", isLiked.value);
//   }

//   void toggleSave() {
//     isSaved.value = !isSaved.value;
//     box.write("isSaved", isSaved.value);
//   }
// }

// // Home Screen
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Home")),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => Get.to(() => ArticleScreen()),
//           child: Text("Go to Article"),
//         ),
//       ),
//     );
//   }
// }

// // Article Screen
// class ArticleScreen extends StatelessWidget {
//   final ArticleController controller = Get.put(ArticleController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 0,
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 320,
//                   width: double.infinity,
//                   child: Image.network(
//                     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSj0y6Vhjobxd6Bkhwc5tQ8qHR4yXifC_oovQ&s",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                   top: 40,
//                   left: 16,
//                   child: GestureDetector(
//                     onTap: () => Get.back(),
//                     child: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 16,
//                   right: 16,
//                   child: Row(
//                     children: [
//                       Obx(() => GestureDetector(
//                             onTap: controller.toggleLike,
//                             child: Icon(
//                               controller.isLiked.value ? Icons.favorite : Icons.favorite_border,
//                               color: controller.isLiked.value ? Colors.red : Colors.white,
//                               size: 16,
//                             ),
//                           )),
//                       const SizedBox(width: 4),
//                       const Text("27", style: TextStyle(color: Colors.white)),
//                       const SizedBox(width: 16),
//                       const Icon(Icons.remove_red_eye, color: Colors.white, size: 16),
//                       const SizedBox(width: 4),
//                       const Text("916", style: TextStyle(color: Colors.white)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "A Beautiful Quarantine Site",
//                     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       const CircleAvatar(
//                         backgroundImage: NetworkImage(
//                           "https://randomuser.me/api/portraits/men/45.jpg",
//                         ),
//                         radius: 20,
//                       ),
//                       const SizedBox(width: 8),
//                       const Text(
//                         "Andy Waruwu",
//                         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
//                       ),
//                       const Spacer(),
//                       IconButton(
//                         onPressed: () {},
//                         icon: const Icon(Icons.share, color: Colors.grey, size: 28),
//                       ),
//                       Obx(() => IconButton(
//                             onPressed: controller.toggleSave,
//                             icon: Icon(
//                               controller.isSaved.value ? Icons.bookmark : Icons.bookmark_border,
//                               color: controller.isSaved.value ? const Color.fromARGB(255, 219, 188, 96): Colors.grey,
//                               size: 28,
//                             ),
//                           )),
//                     ],
//                   ),
//                   const SizedBox(height: 8),

//                   Obx(() => Container(
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: const Color.fromARGB(255, 236, 199, 243),
//                         ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             IconButton(
//                               onPressed: controller.isPlaying.value ? controller.stopSpeaking : controller.speak,
//                               icon: Icon(
//                                 controller.isPlaying.value ? Icons.stop : Icons.play_arrow_rounded,
//                                 size: 40,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                             Expanded(
//                               child: Lottie.asset(
//                                 "Assets/Animations/wave.json",
//                                 height: 70,
//                                 animate: controller.isPlaying.value,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),

//                   const Text(
//                     "This is a sample news article with text-to-speech functionality...",
//                     style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w400),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
