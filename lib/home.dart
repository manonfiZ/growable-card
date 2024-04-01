import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 0;
  List<Content> contents = List.generate(
    4,
    (index) => Content(index: index, image: 'assets/images/${index + 1}.jpg'),
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SizedBox(
          width: size.width,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ...contents.map(
              (e) => GestureDetector(
                onTap: () {
                  setState(() {
                    activeIndex = e.index;
                  });
                },
                child: ExpandableContainer(
                  width: e.index == activeIndex
                      ? size.width / 8 * 4
                      : size.width / 8,
                  image: e.image,
                ),
              ),
            )
          ]),
        ),
      ),
    ));
  }
}

class ExpandableContainer extends StatefulWidget {
  const ExpandableContainer(
      {super.key,
      this.isActive = false,
      required this.width,
      required this.image});

  final bool isActive;
  final double width;
  final String image;

  @override
  State<ExpandableContainer> createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: widget.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(widget.image, fit: BoxFit.cover),
      ),
    );
  }
}

class Content {
  final int index;
  final String image;

  Content({required this.index, required this.image});
}
