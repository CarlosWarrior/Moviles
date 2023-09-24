import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/pages/cafe.dart';
import 'package:proyecto/main_provider.dart';

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
        onTap: () => context.read<MainProvider>().goToCafe(id, context),
        child: ClipRRect(
          child: Stack(
            children: [
              Positioned.fill(child: image),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[700],
                      ),
                      Text(
                        rating,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
