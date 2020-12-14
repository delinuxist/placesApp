import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../screens/add_place_screen.dart';
import '../providers/great_places.dart';
import '../screens/place_detail_screen.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Places',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: JumpingDotsProgressIndicator(
                  fontSize: 60,
                  color: Theme.of(context).accentColor,
                ),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text('Got no places yet, starting adding some...'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => Container(
                          child: Dismissible(
                            confirmDismiss: (direction) {
                              return showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Are you sure?'),
                                  content: Text(
                                      'Do you want to remove this Memory?'),
                                  actions: [
                                    FlatButton(
                                      child: Text('No'),
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                    )
                                  ],
                                ),
                              );
                            },
                            background: Container(
                              height: 20,
                              width: 20,
                              color: Theme.of(context).errorColor,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 40,
                              ),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 4,
                              ),
                            ),
                            onDismissed: (direction) {
                              Provider.of<GreatPlaces>(context, listen: false)
                                  .removeItem(greatPlaces.items[i].id);
                            },
                            direction: DismissDirection.endToStart,
                            key: UniqueKey(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      child: ClipOval(
                                        child: Image.file(
                                          greatPlaces.items[i].image,
                                          fit: BoxFit.cover,
                                          width: 100,
                                        ),
                                      ),
                                    ),
                                    title: Text(greatPlaces.items[i].title),
                                    subtitle: FittedBox(
                                      child: Text(greatPlaces
                                          .items[i].location.address),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        Provider.of<GreatPlaces>(context,
                                                listen: false)
                                            .removeItem(
                                                greatPlaces.items[i].id);
                                      },
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        PlaceDetailScreen.routeName,
                                        arguments: greatPlaces.items[i].id,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
