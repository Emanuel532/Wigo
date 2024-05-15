import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class ItineraryBox extends StatefulWidget {
  final int days;

  const ItineraryBox({Key? key, required this.days}) : super(key: key);

  @override
  State<ItineraryBox> createState() => _ItineraryBoxState();
}

class _ItineraryBoxState extends State<ItineraryBox> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 85, 157, 199),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CarouselSlider.builder(
            carouselController: _controller,
            itemCount: widget.days,
            options: CarouselOptions(
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              int dayNumber = index + 1;
              return ListTile(
                title: Text(
                  'Day $dayNumber',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 42,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                subtitle: SingleChildScrollView(
                  child: Text(
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      '1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n\n\n'),
                ), // Replace with your content
              );
            },
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  _controller.previousPage();
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: () {
                  _controller.nextPage();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
