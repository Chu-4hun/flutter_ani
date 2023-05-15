import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/review.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.outline,
              offset: const Offset(0.0, 1.0), //(x,y)
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: Get.height / 20, // TODO delete Get requirement
                      backgroundImage: NetworkImage(review.avatar),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            review.login,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Text(
                          "${review.revData.toLocal().day}.${review.revData.toLocal().month}.${review.revData.toLocal().year}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${review.rating} / 10",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.star, color: Colors.yellow),
                        ),
                      ],
                    ),
                    Text(
                      softWrap: true,
                      review.reviewText,
                      style: Theme.of(context).textTheme.bodyLarge,
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
