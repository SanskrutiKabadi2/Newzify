import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/aboutUs.dart';
import 'package:untitled/details.dart';
import 'package:untitled/home.dart';
import 'package:untitled/liked.dart';
import 'package:untitled/listTileHome.dart';
import 'package:untitled/saved.dart';

class NewsHomeScreen extends StatefulWidget {
  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late Timer _timer;
  File? _image;
  
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  final List<String> images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTf9nCZlN4cd_0T6I_F-XQNpTbgX0TognU-g&s',
    'https://www.animationxpress.com/wp-content/uploads/2021/09/AAAABe9UGuK5ypr_l6MWT2QflANEaMtgvNk_-2yl7LyoquFHhVvZTV7prNGZkYP4uKRCM8sn3CQcr_7lwflbZnp8yqSaToI8.jpg',
    'https://eu-images.contentstack.com/v3/assets/blt8770191dea35bccc/bltff057ed4a15b068c/67893e2549c1b236dafd55d6/_Oggy_and_the_Cockroaches_Xilam_Animation.png?width=1280&auto=webp&quality=95&format=jpg&disable=upscale',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentIndex < images.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: Colors.white,
  child: Column(
    children: [
      // Drawer Header with blue background
      UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,  // Set background to blue
        ),
        currentAccountPicture: GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child: _image == null
                ? Icon(Icons.add_a_photo, color: Colors.blue)
                : null,
          ),
        ),
        accountName: Text("Sanskruti Kabadi", style: TextStyle(color: Colors.white)),  // White text for account name
        accountEmail: Text("Sanskrutikabadi303@gmail.com", style: TextStyle(color: Colors.white)),  // White text for email
      ),
      
      // White background content below the header
      Expanded(
        child: ListView(
          physics: BouncingScrollPhysics(),  // Optional: Adds smooth scroll effect
          children: [
            ListTile(
              leading: Icon(Icons.person, color: const Color.fromARGB(255, 117, 115, 115)),  // Dark icon
              title: Text('Profile', style: TextStyle(color: const Color.fromARGB(255, 117, 115, 115))),  // Dark text
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.bookmark,color: const Color.fromARGB(255, 117, 115, 115)),
              title: Text('Saved Posts', style: TextStyle(color: const Color.fromARGB(255, 117, 115, 115))),  // Dark text
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return SavedNews();
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite,color: const Color.fromARGB(255, 117, 115, 115)),
              title: Text('Liked Posts', style: TextStyle(color: const Color.fromARGB(255, 117, 115, 115))),  // Dark text
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return LikedNews();
                }));
              },
            ),
            
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {},
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ],
  ),
),
   
      
  
      body: Builder(
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Icon(Icons.menu, color: Colors.black),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Newzify',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.search_outlined),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DiscoverScreen()));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.notifications_none_outlined),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Breaking News', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text('View all', style: TextStyle(color: Colors.blue))
                    ],
                  ),
                ),
                Container(
                  height: 220,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1.0;
                          if (_pageController.position.haveDimensions) {
                            value = (_pageController.page! - index).abs();
                            value = (1 - (value * 0.3)).clamp(0.0, 1.0);
                          }
                          return Transform.translate(
                            offset: Offset(0, 30 * (1 - value)),
                            child: Transform.scale(
                              scale: value,
                              child: child,
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(images[index], fit: BoxFit.cover),
                                Container(
                                  color: Colors.black.withOpacity(0.4),
                                  padding: EdgeInsets.all(16),
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Alexander wears modified helmet in road races',
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: images.length,
                    effect: WormEffect(activeDotColor: Colors.blue, dotHeight: 8, dotWidth: 8),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Recommendation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 64, 61, 61))),
                      Text('View all', style: TextStyle(color: Colors.blue))
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ArticleScreen()));
                          },
                          child: HomeNewsTile(
                            imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-joDW80HIi7WIer3DwtsU99R_vOZBZBYfWg&s",
                            title: "Cybersecurity Alert: New Malware Targeting Smartphones.",
                            description: "Hhabbbbb",
                            content: "HJHII",
                            time: "2.30pm",
                            author: "Sans Kabadi",
                            isLiked: false,
                            isSaved: false,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}
