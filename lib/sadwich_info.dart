import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SandwichInfo extends StatelessWidget {
  final int _id;
  final String _image;
  final String _title;
  final String _description;
  final double _prix;

  const SandwichInfo(
      this._id, this._image, this._title, this._description, this._prix);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () async {
          print("zok khéltek");
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setInt("id", _id);
          prefs.setString("image", _image);
          prefs.setString("title", _title);
          prefs.setString("description", _description);
          prefs.setDouble("prix", _prix);
          Navigator.pushNamed(context, "/details");
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Image.network("http://10.0.2.2:3002/" + _image,
                  width: 400, height: 400),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_title, textScaleFactor: 2),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _prix.toString() + " DT ",
                  textScaleFactor: 1,
                  style: const TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
