import 'package:flutter/material.dart';

class CoffeCardComponent extends StatelessWidget {
  final String id;
  final Widget image;
  final String title;
  final String rating;
  final bool favorite;
  final VoidCallback onTap;
  const CoffeCardComponent({
    super.key,
    required this.image,
    required this.title,
    required this.rating,
    required this.id,
    required this.favorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: InkWell(
        splashColor: Colors.deepOrangeAccent[100],
        borderRadius: BorderRadius.circular(8),
        onTap: this.onTap,
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
                  top: 0,
                  right: 0,
                  child: favorite
                      ? Icon(Icons.favorite, color: Colors.red)
                      : Text("")),
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
