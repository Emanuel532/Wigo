import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetSelector extends StatefulWidget {
  @override
  _BudgetSelectorState createState() => _BudgetSelectorState();
}

class _BudgetSelectorState extends State<BudgetSelector> {
  int _selectedBudgetIndex = 0;
  final List<String> _budgetOptions = ['\$', '\$\$', '\$\$\$'];
  final Color blue = Color.fromARGB(255, 85, 157, 199);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Budget',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: blue,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          ToggleButtons(
            isSelected: List.generate(_budgetOptions.length,
                (index) => index == _selectedBudgetIndex),
            onPressed: (index) {
              setState(() {
                _selectedBudgetIndex = index;
              });
            },
            selectedColor: Colors.white,
            splashColor: blue,
            fillColor: blue,
            borderColor: blue,
            selectedBorderColor: blue,
            borderRadius: BorderRadius.circular(5.0),
            children: _budgetOptions.map((option) {
              int optionIndex = _budgetOptions.indexOf(option);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 32.0,
                    color: optionIndex == _selectedBudgetIndex
                        ? Colors.white
                        : blue,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
