import 'package:flutter/material.dart';

class MovieTileWithPlay extends StatelessWidget {
  const MovieTileWithPlay({
    super.key,
    required this.img,
    required this.title,
    required this.description,
    required this.episode,
    required this.duration,
    this.height,
    required this.onClick,
  });

  final String img;
  final String title;
  final String description;
  final int episode;
  final double duration;
  final double? height;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.outline,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 7 / 9,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.centerLeft,
                image: NetworkImage(img),
              )),
            ),
          ),
          // Image.network(img),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        decorationStyle: TextDecorationStyle.wavy),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(
                        description,
                        softWrap: true,
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton.icon(
                        onPressed: onClick,
                        icon: const Icon(Icons.play_arrow_outlined),
                        label: Text(
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                decorationStyle: TextDecorationStyle.wavy),
                            "Серия: ${episode} Время: ${duration}"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
