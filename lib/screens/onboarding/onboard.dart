import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  final pages = List.generate(
      3,
      (index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade300,
            ),
            child: Container(
              height: 30,
              child: Center(
                  child: Text(
                "Page $index",
                style: const TextStyle(color: Color.fromARGB(255, 70, 76, 109)),
              )),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // page view
          const SizedBox(
            height: 200,
          ),
          SizedBox(
            child: PageView(
              controller: controller,
              children: const [],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // dot indicators
          SmoothPageIndicator(
            controller: controller,
            count: pages.length,
            effect: const ExpandingDotsEffect(
              dotColor: Colors.white54,
              activeDotColor: Colors.blue,
              dotHeight: 10,
              dotWidth: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Button(
          //   key: Key('Next'),
          // ),
          ElevatedButton(
              // statesController:
              //     MaterialStatesController(controller as Set<MaterialState>?),
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60)))),
                padding: MaterialStatePropertyAll(EdgeInsets.only(
                    left: 150, right: 150, bottom: 15, top: 15)),
              ),
              onPressed: () {},
              child: const Text("Next"))
        ],
      ),
    );
  }
}
