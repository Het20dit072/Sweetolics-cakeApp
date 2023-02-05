import 'package:flutter/material.dart';
import 'package:sweetolics_cakeapp/screens/widgets/bottomsheet.dart';

class Cake_Card extends StatelessWidget {
  Cake_Card(
      {required this.img,
      required this.title,
      required this.subtitle,
      required this.price});

  final String img;
  final String title;
  final String subtitle;
  final String price;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10.0, 5.0, 20.0, 5.0),
          height: 200.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(160, 10.0, 10.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 120.0,
                      child: Text(
                        '${title}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ],
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 120.0,
                      child: Text(
                        '${price} ₹',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: () {
                      bottomsheetcake(context);
                    },
                    child: Container(
                      width: 150,
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: Color(0xfff42b51),
                          borderRadius: BorderRadius.circular(10.0)),
                      alignment: Alignment.center,
                      child: Text(
                        'order now',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 10.0,
          top: 5.0,
          bottom: 12,
          child: ClipRRect(
            child: Image(
              width: 150.0,
              image: AssetImage(img),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
