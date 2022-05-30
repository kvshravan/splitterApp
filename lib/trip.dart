import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collection/collection.dart';
import 'package:share_plus/share_plus.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key? key, required this.pageTitle}) : super(key: key);
  final String pageTitle;

  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController expenseController = TextEditingController();
  List membersList = [];
  String s = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.pageTitle,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20,
            letterSpacing: .3,
          ),
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
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                width: 250,
                height: 80,
                child: MaterialButton(
                    splashColor: Colors.white70,
                    onPressed: () async {
                      List val = await openDialog();
                      setState(() {
                        if (val[0].isNotEmpty && val[1].isNotEmpty) {
                          membersList.add([val[0], val[1]]);
                          print(membersList);
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.add_circle,
                          size: 22,
                          color: Colors.white,
                        ),
                        Text(
                          'Add member',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            letterSpacing: .3,
                          ),
                        ),
                      ],
                    ),
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: membersList.length,
                itemBuilder: (context, index) {
                  return Card(
                      color: Colors.white60,
                      shadowColor: Colors.white,
                      child: ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              membersList.removeAt(index);
                            });
                          },
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.black54,
                          ),
                        ),
                        onTap: () {},
                        title: Text(
                          membersList[index][0],
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            letterSpacing: .3,
                          ),
                        ),
                        subtitle: Text(
                          membersList[index][1],
                          style: GoogleFonts.openSans(
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            letterSpacing: .3,
                          ),
                        ),
                      ));
                },
              ),
            )),
            MaterialButton(
                splashColor: Colors.white70,
                onPressed: () {
                  if (membersList.length > 0) {
                    _performCalculation();
                    _openBottomSheet();
                  }
                },
                color: Colors.orange,
                textColor: Colors.white,
                child: Icon(
                  Icons.check,
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

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Text(
            'Add a member',
            style: GoogleFonts.openSans(
              color: Colors.orange,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: .3,
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                      style: GoogleFonts.openSans(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        letterSpacing: .3,
                      ),
                      cursorHeight: 25,
                      controller: nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Enter name',
                        hintStyle: GoogleFonts.openSans(
                          color: Colors.orange,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                      style: GoogleFonts.openSans(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        letterSpacing: .3,
                      ),
                      cursorHeight: 25,
                      controller: expenseController,
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Enter expense',
                        hintStyle: GoogleFonts.openSans(
                          color: Colors.orange,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      )),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop([
                  nameController.text.trim(),
                  expenseController.text.trim()
                ]);
                nameController.clear();
                expenseController.clear();
              },
              child: Text(
                'SUBMIT',
                style: GoogleFonts.openSans(
                  color: Colors.orange,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  letterSpacing: .3,
                ),
              ),
            )
          ],
        ),
      );

  _openBottomSheet() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: FutureBuilder<List>(
              future: _performCalculation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 40,
                          child: Divider(
                            thickness: 3.0,
                            height: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  color: Colors.white60,
                                  shadowColor: Colors.white,
                                  child: ListTile(
                                    onTap: () {},
                                    title: Text(
                                      snapshot.data![index][0] +
                                          ' should pay ' +
                                          snapshot.data![index][1]
                                              .toStringAsFixed(2) +
                                          ' to ' +
                                          snapshot.data![index][2],
                                      style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        letterSpacing: .2,
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                            splashColor: Colors.white70,
                            onPressed: () {
                              String text =
                                  'Splitter - ' + widget.pageTitle + '\n';
                              for (int i = 0; i < snapshot.data!.length; i++) {
                                text += snapshot.data![i][0] +
                                    ' should pay ' +
                                    snapshot.data![i][1].toStringAsFixed(2) +
                                    ' to ' +
                                    snapshot.data![i][2] +
                                    '\n';
                              }
                              Share.share(text);
                            },
                            color: Colors.black,
                            textColor: Colors.white,
                            child: Icon(
                              Icons.share,
                              size: 22,
                            ),
                            padding: EdgeInsets.all(18),
                            shape: CircleBorder()),
                      )
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        });
  }

  Future<List> _performCalculation() async {
    double avg = 0, sum = 0;
    List transactions = [];
    for (var i = 0; i < membersList.length; i++) {
      sum = sum + double.parse(membersList[i][1]);
    }
    avg = sum / (membersList.length);
    final send = PriorityQueue<List>((a, b) {
      if (a[1] > b[1]) {
        return -1;
      }
      return 1;
    });
    final recieve = PriorityQueue<List>((a, b) {
      if (a[1] > b[1]) {
        return -1;
      }
      return 1;
    });
    double dev;
    for (int i = 0; i < membersList.length; i++) {
      dev = double.parse(membersList[i][1]) - avg;
      if (dev < 0) {
        send.add([membersList[i][0], -dev]);
      }
      if (dev > 0) {
        recieve.add([membersList[i][0], dev]);
      }
    }
    var delta = 0.1, maxrec, maxsend, balance;
    while (recieve.isNotEmpty) {
      maxrec = recieve.removeFirst();
      maxsend = send.removeFirst();
      if (maxsend[1] > maxrec[1]) {
        transactions.add([maxsend[0], maxrec[1], maxrec[0]]);
        balance = maxsend[1] - maxrec[1];
        send.add([maxsend[0], balance]);
      } else {
        transactions.add([maxsend[0], maxsend[1], maxrec[0]]);
        balance = maxrec[1] - maxsend[1];
        if (balance > delta) {
          recieve.add([maxrec[0], balance]);
        }
      }
    }
    var map = Map();
    for (int i = 0; i < transactions.length; i++) {
      if (map.containsKey(transactions[i][0])) {
        map[transactions[i][0]].add(transactions[i]);
      } else {
        map[transactions[i][0]] = [];
        map[transactions[i][0]].add(transactions[i]);
      }
    }
    List newtransactions = [];
    for (String key in map.keys) {
      for (int i = 0; i < map[key].length; i++) {
        newtransactions.add(map[key][i]);
      }
    }
    return newtransactions;
  }
}
