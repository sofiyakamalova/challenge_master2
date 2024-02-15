import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Enter City Name',
          labelStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.black,
            size: 30,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
