import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FloatingSearchBar(
          hint: 'Search',
          openAxisAlignment: 0.0,
          axisAlignment: 0.0,
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 20),
          elevation: 4.0,
          physics: const BouncingScrollPhysics(),
          onQueryChanged: (query) {
            //Your methods will be here
          },
          transitionCurve: Curves.easeInOut,
          transitionDuration: const Duration(milliseconds: 500),
          transition: CircularFloatingSearchBarTransition(),
          debounceDelay: const Duration(milliseconds: 500),
          actions: [
            FloatingSearchBarAction(
              showIfOpened: false,
              child: CircularButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  print('Places Pressed');
                },
              ),
            ),
            FloatingSearchBarAction.searchToClear(
              showIfClosed: false,
            ),
          ],
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Material(
                color: Colors.black,
                child: Container(
                  height: 200.0,
                  color: Colors.white,
                  child: SizedBox(
                    height: 200.0,
                    child: ListView(
                      children: const [
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                        ListTile(
                          title: Text('Home'),
                          subtitle: Text('more info here........'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
