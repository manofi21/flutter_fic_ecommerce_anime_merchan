import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.grey[900]!,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  child: Icon(Icons.search, size: 20),
                ),
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration.collapsed(
                      // constraints: BoxConstraints.tightFor(height: 15),
                      hintText: "Pencarian",
                      border: InputBorder.none,
                    ).copyWith(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.mic, size: 20),
        ],
      ),
    );
  }
}
