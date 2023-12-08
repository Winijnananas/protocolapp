import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import './CamScreen.dart'; // นำเข้าหน้า CamScreen
import './About.dart';

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
  final List<String> frequentlyAskedQuestions = [
    '1.คุณต้องการความช่วยเหลือ ?',
    '2.ห้องน้ำไปทางไหน ? ',
    '3.RTC คืออะไร ',
    '4.ธนาคารไปทางไหน ? ',
    '5.ทำธุรกรรมได้ที่ไหน ? ',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HOME',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ImageSlider(),
              ),
            ],
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
                      minimumSize: Size(300, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(7) // No borderRadius
                          ), // Set minimum width and height
                    ),
                    child: Text(
                      'CONTACT STAFF',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  SizedBox(
                      height:
                          20), // Adding space between the button and FAQ list
                  // Text(
                  //   'คำถามที่พบบ่อย',
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  // ),
                  // Column(
                  //   children: frequentlyAskedQuestions
                  //       .map((question) => ListTile(
                  //             title: Text(question),
                  //             onTap: () {
                  //               // Handle tapping on a question
                  //             },
                  //           ))
                  //       .toList(),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
