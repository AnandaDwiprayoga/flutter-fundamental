import 'package:flutter/material.dart';
import 'package:routing/album_model.dart';
import 'package:routing/networking.dart';

class AlbumPageState extends StatefulWidget {
  @override
  _AlbumPageStateState createState() => _AlbumPageStateState();
}

class _AlbumPageStateState extends State<AlbumPageState> {
  Future<Album> _futureAlbum;

// hanya akan dijalankan sekali ketika widget di build
  @override
  void initState() {
    super.initState();
    // Sebaiknya pemanggilan API berada di initState dan tidak disarankan
    // dijalankan pada method build
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fetch Data Sample")),
      body: Center(
        child: FutureBuilder<Album>(
            future: _futureAlbum,
            builder: (context, snapshot) {
              var state = snapshot.connectionState;

              if (state != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  return Text(snapshot.data.title);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error),
                  );
                } else {
                  return Text('');
                }
              }
            }),
      ),
    );
  }
}
