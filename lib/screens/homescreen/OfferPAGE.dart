import 'package:flutter/material.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/HomeScreen.dart';

class OfferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MyHomePage()));
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Cake Offers',
          style: TextStyle(color: Colors.brown),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildOfferCard(
                context, 'assets/images/Cake1.jpg', '20% off', 'April 15-16'),
            _buildOfferCard(
                context, 'assets/images/Cake2.jpg', '30% off', 'April 17-18'),
            _buildOfferCard(
                context, 'assets/images/Cake3.jpg', '60% off', 'April 19-20'),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(
      BuildContext context, String image, String discount, String date) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(discount,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('on all cakes', style: TextStyle(fontSize: 16)),
                SizedBox(height: 5),
                Text('Valid on $date', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
