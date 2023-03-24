import 'package:flutter/material.dart';
import 'package:flutter_ani/utils/UI/movie_card.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class TitlesPage extends StatelessWidget {
  const TitlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridList(
      horizontalGridMargin: 10,
      verticalGridMargin: 10,
      minItemWidth: 150,
      maxItemsPerRow: 4,
      children: List.generate(
        100,
        (index) => MovieCard(onTap: (){}, img: Image.network(fit: BoxFit.cover,"https://animego.org/upload/anime/images/5ad264d801ac6117576552.jpg"), title: "Крутой учитель Онидзука", rating: "9.6")
      ),
    );
  }
}
