import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../models/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LOCATOR",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: myList
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "second", arguments: e);
                  },
                  child: Logic(
                    e['link'],
                    e['name'],
                    e['text'],
                    e['image'],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget Logic(Image cimg, String name, String pname, AssetImage pimg) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Neumorphic(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              cimg,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    pname,
                    style: const TextStyle(fontSize: 17, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              CircleAvatar(
                radius: 35,
                backgroundImage: pimg,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.025,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
