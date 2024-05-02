import 'package:flutter/material.dart';
import 'package:movie_app/pages/actors_list_page.dart';
import 'package:movie_app/pages/comments_page.dart';
import 'package:movie_app/pages/news_list_page.dart';
import 'package:movie_app/pages/stuff_list_page.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package
import 'dart:ui';

void main() {
  runApp(const MoviePage());
}

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Set the theme to dark
      home: Scaffold(
        backgroundColor: Colors.black, // Set the background color to black
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 260,
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Image.asset(
                                'images/movie_img.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                'Planet of the Apes',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.white.withOpacity(0.1), // Adjust the opacity to control the blur effect
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _launchURL('https://www.youtube.com/watch?v=P1yKN0llkrY&t=4s');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent, // Make button background transparent
                                      shadowColor: Colors.transparent, // Make button shadow transparent
                                      elevation: 0, // Remove the elevation
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0), // Set the button shape
                                      ),
                                    ),
                                    child: const Text('Watch Trailer'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0), // Set the container shape
                        color: Colors.white.withOpacity(0.1), // Adjust the opacity to control the blur effect
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Publication Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 5),
                              Text(
                                'Publication Date:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '11.08.2011',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.access_time),
                              SizedBox(width: 5),
                              Text(
                                'Time:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                '105 min',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const ActorsListButton(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActorWidget(imageAsset: 'images/james_franco.jpeg', name: 'James Franco', role: 'Will Rodman'),
                  ActorWidget(imageAsset: 'images/andy.jpeg', name: 'Andy Serkis', role: 'Caesar'),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0), // Set the container shape
                  color: Colors.white.withOpacity(0.1), // Adjust the opacity to control the blur effect
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NewsListButton(),
                    CommentsListButton(),
                    StaffListButton(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rating:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8.0), // Adjust the left padding as needed
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star_border, color: Colors.yellow),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ButtonList(),

            ],
          ),
        ),
      ),
    );
  }

  // Function to launch URL
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ActorWidget extends StatelessWidget {
  final String imageAsset;
  final String name;
  final String role;

  const ActorWidget({Key? key, required this.imageAsset, required this.name, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imageAsset,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'Arial', // Change the font for actor names
          ),
        ),
        Text(
          role,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class StaffListButton extends StatelessWidget {
  const StaffListButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StuffListPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 0, // Remove the elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Set the button shape
        ),
      ),
      child: const Text('Staff List'),
    );
  }
}

class ActorsListButton extends StatelessWidget {
  const ActorsListButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ActorsListPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 0, // Remove the elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Set the button shape
        ),
      ),
      child: const Text('Actors List'),
    );
  }
}

class NewsListButton extends StatelessWidget {
  const NewsListButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewsListPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 0, // Remove the elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Set the button shape
        ),
      ),
      child: const Text('News List'),
    );
  }
}

class CommentsListButton extends StatelessWidget {
  const CommentsListButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CommentsListPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 0, // Remove the elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Set the button shape
        ),
      ),
      child: const Text('Comments List'),
    );
  }
}

class ButtonList extends StatelessWidget {
  const ButtonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
