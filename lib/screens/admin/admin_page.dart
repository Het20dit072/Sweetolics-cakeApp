import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sweetolics_cakeapp/screens/homescreen/customizeCake.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool _isApproved = false;
  bool _isRejected = false;
  void _approveOrder(String orderId) {
    FirebaseFirestore.instance
        .collection('cakes')
        .doc('cSxEMSbAhLNVutjME8SkRwR4s362')
        .collection('orders')
        .doc(orderId)
        .update({'Approved': true});
    setState(() {
      _isApproved = true;
      _isRejected = false;
    });
  }

  void _rejectOrder(String orderId) {
    FirebaseFirestore.instance
        .collection('cakes')
        .doc('cSxEMSbAhLNVutjME8SkRwR4s362')
        .collection('orders')
        .doc('cSxEMSbAhLNVutjME8SkRwR4s362')
        .update({'Approved': false});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cakes')
            .doc('cSxEMSbAhLNVutjME8SkRwR4s362')
            .collection('orders')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var order = snapshot.data!.docs[index];
              var orderId = order.id;

              return Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    title: Text(
                      'Order $orderId',
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          'Cake Shape: ${order['Cake Shape']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Cake Type: ${order['cake Type']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Budget: ${order['budget']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Cake Tier: ${order['Cake Tier']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Servings: ${order['Servings (100g per person)']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            MaterialButton(
                              onPressed: () async {
                                _approveOrder(orderId);
                                await ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text("Approved")),
                                );
                              },
                              child: Icon(Icons.check),
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            MaterialButton(
                              onPressed: () async {
                                _rejectOrder(orderId);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text("Rejected")),
                                );
                              },
                              child: Icon(Icons.close),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
