import 'package:flutter/material.dart';

class CoffeCardComponent extends StatelessWidget {
  final String id;
  final Widget image;
  final String title;
  final String rating;
  const CoffeCardComponent(
      {super.key,
      required this.image,
      required this.title,
      required this.rating,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: InkWell(
        splashColor: Colors.deepOrangeAccent[100],
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Stack(
          children: [
            Positioned.fill(child: image),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black87
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: null,
              child: Container(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Icon(Icons.star, color: Colors.yellow),
                        Text(
                          "$rating",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
