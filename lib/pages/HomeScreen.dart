import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import './CamScreen.dart'; // นำเข้าหน้า CamScreen

class ImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Image.network(
          'https://edtprod1.edtguide.com/edtguide/assets/Central_NKR_132.jpg',
          fit: BoxFit.cover,
        ),
        Image.network(
          'https://www.hubspot.com/hubfs/how%20to%20make%20an%20ad.png', // Replace this URL with your image URL
          fit: BoxFit.cover,
        ),
        Image.network(
          'https://edtprod1.edtguide.com/edtguide/assets/Central_NKR_132.jpg', // Replace this URL with your image URL
          fit: BoxFit.cover,
        ),
        // Add more Image.network widgets for additional images from URLs
      ],
      options: CarouselOptions(
        height: 200, // Adjust height as needed
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CentralRTCApp',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ImageSlider(),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // When the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CamScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Background color red
                      onPrimary: Colors.white, // Text color white
                      minimumSize:
                          Size(400, 50), // Set minimum width and height
                    ),
                    child: Text(
                      'ติดต่อเจ้าหน้าที่',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
