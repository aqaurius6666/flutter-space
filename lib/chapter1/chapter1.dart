import 'package:flutter/material.dart';

const pic =
    "https://lh4.googleusercontent.com/OzP1cRxM6ZlJL9MbIRwYpIMlS-t641UDrJ7H5J2WvXg2Y1sy9Q9Ks6TlhlJEB3YGKHblJXCcCibMe2cs0Y1W=w1592-h989-rw";

class Chapter1App extends StatelessWidget {
  const Chapter1App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Beloved",
        home: Scaffold(
            appBar: AppBar(
                title: const Text("Beloved"),
                backgroundColor: Colors.deepPurple),
            body: Builder(
                builder: (context) => SingleChildScrollView(
                  child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                            child: Column(
                          children: [
                            const Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Hello Hằng <3",
                                  style: TextStyle(
                                      fontSize: 26, fontWeight: FontWeight.bold),
                                )),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("iu _._",
                                  style: TextStyle(
                                      fontSize: 26, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Image.network(pic),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: ElevatedButton(
                                  child: const Text("Đấm cái"),
                                  onPressed: () => punishHang(context)),
                            )
                          ],
                        )),
                      ),
                ))));
  }

  void punishHang(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext build) {
          return AlertDialog(
            title: const Text("Có chắc nỡ đấm không?"),
            content: const Center(child: Text("Gan thì nhích"), heightFactor: 1,),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Đấm'))
            ],
          );
        });
  }
}
