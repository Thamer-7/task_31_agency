import 'package:flutter/material.dart';

class SizeList extends StatefulWidget {
  @override
  State<SizeList> createState() => _SizeListState();
}

class _SizeListState extends State<SizeList> {
  final List<String> sizeList = ['S', 'M', 'L', 'XL', 'XXL'];
  var currentSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    currentSelected = index;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: currentSelected == index
                          ? Colors.amber.withOpacity(0.2)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.1), width: 2)),
                  child: Text(
                    sizeList[index],
                    style: TextStyle(
                        color: currentSelected == index
                            ? Colors.amber
                            : Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          separatorBuilder: (_, index) => const SizedBox(
                width: 10,
              ),
          itemCount: sizeList.length),
    );
  }
}
