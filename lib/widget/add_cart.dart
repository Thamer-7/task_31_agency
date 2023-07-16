import 'package:flutter/material.dart';

class AddCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          const Column(
            children: [
              Text(
                'Price',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                '\$78.99',
                style: TextStyle(
                    height: 1.5, fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    elevation: 0,
                    primary: Colors.amber,
                  ),
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Add to Cart', style: TextStyle(
                        fontSize: 20,
                      ),),
                      SizedBox(width: 10,),
                      Icon(Icons.shopping_cart_outlined)
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
