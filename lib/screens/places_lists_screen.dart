import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your places'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            )
          ],
        ),
        body: Consumer<GreatPlaces>(
          child: Center(
            //the child of the consumer won't rebuild when the listened provider is changing, we will use it below in the buildr as ch
            child: const Text('Got not places yet, start adding some'),
          ),
          builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
              ? ch
              : ListView.builder(
                  itemCount: greatPlaces.items.length,
                  itemBuilder: (ctx, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        greatPlaces.items[index].image,
                      ),
                    ),
                    title: Text('${greatPlaces.items[index].title}'),
                    onTap: () {
                      //GO TO DETAIL PAGE
                    },
                  ),
                ),
        ));
  }
}
