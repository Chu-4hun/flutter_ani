import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ReviewForm extends StatefulWidget {
  ReviewForm({
    super.key,
    required this.submitFunction,
  });

  final void Function(double rating, String text) submitFunction;

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  double rating = 0;
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Оцените релиз: ${rating.toInt()}/10",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 5,
            ),
            SmoothStarRating(
                allowHalfRating: false,
                onRatingChanged: (v) {
                  rating = v;
                  setState(() {});
                },
                starCount: 10,
                rating: rating,
                size: 40.0,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star,
                color: Theme.of(context).colorScheme.primary,
                borderColor: Theme.of(context).colorScheme.tertiary,
                spacing: 0.0),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _textEditingController,
              maxLength: 254,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Напишите ваш отзыв',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                    
                    onPressed: () {
                      widget.submitFunction(
                          rating, _textEditingController.text);
                      rating = 0;
                      _textEditingController.text = "";
                      setState(() {});
                    },
                    child: Text("Отправить")))
          ],
        ),
      ),
    );
  }
}
