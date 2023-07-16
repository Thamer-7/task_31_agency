import 'package:flutter/material.dart';
import 'package:task_31_agency/widget/add_cart.dart';
import 'package:task_31_agency/widget/size_list.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 600,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('images/hoodie.jpg'),
                        fit: BoxFit.fitHeight),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 25,
                    right: 25,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(1),
                              shape: BoxShape.circle),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(1),
                            shape: BoxShape.circle),
                        child: const Icon(
                          Icons.more_horiz,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Gucci oversize Hoodi',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amber.withOpacity(0.8),
                                  shape: BoxShape.rectangle,
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  quantity--;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              quantity.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amber.withOpacity(0.8),
                                  shape: BoxShape.rectangle,
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_border,
                            color: Colors.amber,
                          ),
                          Text('4.5 (2.7k)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ],
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text:
                                  'Gucci Oversize Hoodie, a hoodie with the Style of gucci\nmade of soft sikl fabric,and made with on oversized\nmode according to today\'s times ',
                              style:
                                  TextStyle(color: Colors.grey, height: 1.5)),
                          TextSpan(
                              text: 'Read More',
                              style: TextStyle(color: Colors.amber)),
                        ],
                      ),
                    ),
                    SizeList(),
                    AddCart(),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
