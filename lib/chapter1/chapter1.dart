import 'package:flutter/material.dart';

const pic =
    "https://scontent-hkg4-1.cdninstagram.com/v/t51.2885-19/264255549_1053512348835368_4170754653493169392_n.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent-hkg4-1.cdninstagram.com&_nc_cat=108&_nc_ohc=ZfHm-Ky75RsAX9l4Xx-&edm=AABBvjUBAAAA&ccb=7-4&oh=00_AT8J4Btz3FRjIG7JO_fD7THQETrVg053-bUiKL7F4wdoKg&oe=6229324A&_nc_sid=83d603";

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
                builder: (context) => Padding(
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
