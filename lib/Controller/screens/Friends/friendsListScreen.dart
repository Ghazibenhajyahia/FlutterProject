import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportpal/Model/Notification.dart' as notif;
import 'package:sportpal/Service/PlayerService.dart';

import '../../../Model/Player.dart';
import '../../../Service/NotificationService.dart';
import '../Messanger/ChatScreen.dart';
class FriendsListScreen extends StatefulWidget {
  const FriendsListScreen({Key? key}) : super(key: key);

  @override
  _FriendsListScreenState createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {
  final listKey = GlobalKey<AnimatedListState>();

  late Future<bool> fetchedUser;
  late String id;
  late List<Player>? playerInvitation;
  final List<Player> news = [];
  late SharedPreferences prefs;

  Future<bool> fetchUser() async {

    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("_id")!;

     var test = await PlayerService().getFriends(id);
     print(test);
    test?.forEach((element) {
    //   if(element.accept){
    //     if(element.type! == "Friend request"){
    //       if(id==element.from!.id){
    //         playerInvitation!.add(element.to[0]!) ;
    //       }else{
    //         playerInvitation!.add(element.from!);
    //       }
          news.add(element);
    //     }
    //
    //   }
     });

    setState(() {

    });

    return true;
  }

  @override
  void initState() {
    fetchedUser= fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: fetchedUser ,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if(snapshot.hasData) {
                return AnimatedList(
                  key: listKey,
                  initialItemCount: news.length,
                  itemBuilder: (context, index, animation) {

                    return ListItemWidget(
                        item: news[index],
                        animation: animation,
                        onClicked: () {

                        });
                  },);
              }
              else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }})
    );}

  void removeItem(int index) {
    final removedItem = news[index];
    news.removeAt(index);
    listKey.currentState!.removeItem(
        index,
            (context, animation) => ListItemWidget(
          item: removedItem,
          animation: animation,
          onClicked: () {
          },
        ),
        duration: Duration(milliseconds: 600));
  }
}

class ListItemWidget extends StatelessWidget {
  final Player item;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  const ListItemWidget(
      {Key? key,
        required this.item,
        required this.animation,
        required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatScreen(user: item,)));
        },
        leading: CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(item.profilePic!),
        ),
        title: Text(
          item.fullName!,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          item.birthDate.toString(),
          style: TextStyle(fontSize: 12),
        ),
        contentPadding: EdgeInsets.all(16),
      ),
    );
  }

}
