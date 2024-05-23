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

    if (days == 0) {
      return Container(
        decoration: BoxDecoration(
          color: Color(0xFF559DC7),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 10.0,
            ),
          ],
        ),
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            'No itinerary available',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF559DC7),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 10.0,
          ),
        ],
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CarouselSlider.builder(
            carouselController: _controller,
            itemCount: days,
            options: CarouselOptions(
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              int dayNumber = index + 1;
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 4),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Day $dayNumber',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Color(0xFF559DC7),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.itineraryItems[index]
                              .split('\n')
                              .map((paragraph) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Text(
                                      paragraph,
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
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
