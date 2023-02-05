import 'package:flutter/material.dart';
import 'package:sweetolics_cakeapp/screens/initial_page.dart';
import 'package:sweetolics_cakeapp/screens/widgets/cake_menu.dart';

Future bottomsheetcake(BuildContext context) {
  bool isFinished = false;

  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.white
                // gradient: LinearGradient(colors: [
                //   Color.fromARGB(132, 135, 0, 0),
                //   Color.fromARGB(166, 43, 21, 14)
                // ])
                ),
            height: 600,
            child: Column(
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            "assets/images/backery.png",
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: menuItemtab_quantity(
                    CardName: "Servings(100g/person)",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(3.5, 15, 0, 20),
                  child: menuItemtab_quantity(
                    CardName: "Quantity (No of Cakes)",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, top: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "What you want to see on Cake ?",
                      style: TextStyle(
                          color: Color(0xffc02444),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 35, 35, 60),
                  child: Container(
                    child: TextFormField(
                      // controller: _PetNameController,
                      decoration: InputDecoration(
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Color(0xffc02444))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Color(0xffc02444))),
                        labelText: 'Name On Cake',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint('ElevatedButton Clicked');
                      },
                      child: Text('Next'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffc02444),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ));
      });
}
