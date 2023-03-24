import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(
      {super.key,
      required this.onTap,
      this.title,
      this.rating, required this.img});
  final VoidCallback onTap;
  final Image img;
  final String? title;
  final String? rating;

  static const double borderRadius = 15;

  @override
  Widget build(BuildContext context) {
    rating ?? "0";
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 3,
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(borderRadius), // Image border
                  child: img,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title ?? "Movie Title",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: Row(
                  children: [
                    Text(
                      "$rating / 10",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.star, color: Colors.yellow),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
