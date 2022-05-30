import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/trip.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  TextEditingController textFieldController = TextEditingController();

  final textStyle = GoogleFonts.openSans(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 20,
    letterSpacing: .3,
  );
  void _navigatetotrip(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TripPage(
                  pageTitle: textFieldController.text.trim(),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light),
        title: Text(
          'Splitter',
          style: textStyle,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        elevation: 2.0,
        backgroundColor: Colors.orange,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Splitter equally splits expenses among your group members and helps you clear your group debts.',
                    style: GoogleFonts.openSans(
                      color: Colors.orange,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                width: 400,
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                            controller: textFieldController,
                            style: GoogleFonts.openSans(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: .3,
                            ),
                            cursorHeight: 25,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Enter event/trip name',
                              hintStyle: GoogleFonts.openSans(
                                color: Colors.orange,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            MaterialButton(
                splashColor: Colors.white70,
                onPressed: () {
                  final val = textFieldController.text.trim();
                  if (val.isNotEmpty) {
                    _navigatetotrip(context);
                  }
                },
                color: Colors.orange,
                textColor: Colors.white,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 22,
                ),
                padding: EdgeInsets.all(18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))))
          ],
        ),
      ),
    );
  }
}
