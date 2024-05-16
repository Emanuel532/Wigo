import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class ItineraryBox extends StatefulWidget {
  final List<String> itineraryItems;

  const ItineraryBox({
    Key? key,
    required this.itineraryItems,
  }) : super(key: key);

  @override
  State<ItineraryBox> createState() => _ItineraryBoxState();
}

class _ItineraryBoxState extends State<ItineraryBox> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    int days = widget.itineraryItems.length;

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
            itemCount: days,
            options: CarouselOptions(
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              int dayNumber = index + 1;
              return ListTile(
                title: Row(
                  children: [
                    Text(
                      'Day $dayNumber',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 64,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
                subtitle: SingleChildScrollView(
                  child: Text(
                    widget.itineraryItems[
                        index], // Use the itinerary item for this day
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
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
