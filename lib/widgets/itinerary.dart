import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ItineraryBox extends StatefulWidget {
  final int days;

  const ItineraryBox({Key? key, required this.days}) : super(key: key);

  @override
  State<ItineraryBox> createState() => _ItineraryBoxState();
}

class _ItineraryBoxState extends State<ItineraryBox> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.days,
      options: CarouselOptions(
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        int dayNumber = index + 1;
        return ListTile(
          title: Text('Day $dayNumber'),
          subtitle: SingleChildScrollView(
            child: Text('1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n\n\n'),
          ), // Replace with your content
        );
      },
    );
  }
}
