import 'package:flutter/material.dart';
import 'package:flutter_ani/pages/home/titles_grid_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            title: Container(
              alignment: Alignment.center,
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  labelText: "Search",
                  hintText: 'Enter a search term',
                ),
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(child: Text('Для меня')),
                Tab(child: Text('Кино')),
                Tab(child: Text('Сериалы')),
                Tab(child: Text('Новинки')),
              ],
            ),
          ),
        ],
        body: TabBarView(
          children: <Widget>[
            Icon(Icons.flight, size: 350),
            TitlesPage(),
            Icon(Icons.directions_car, size: 350),
            Icon(Icons.directions_bike, size: 350),
          ],
        ),
      )),
    );
  }
}

        //    
        // 