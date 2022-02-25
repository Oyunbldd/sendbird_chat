import 'package:flutter/material.dart';
import 'package:sendbird_flutter_dashchat/group_channel_view.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class ChannelListView extends StatefulWidget {
  @override
  _ChannelListViewState createState() => _ChannelListViewState();
}

class _ChannelListViewState extends State<ChannelListView> with ChannelEventHandler {
  List<GroupChannel> groupChannelList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: BackButton(color: Theme.of(context).primaryColor),
        title: const Text(
          'Channels',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
            width: 60,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/create_channel');
              },
              child: const Icon(Icons.abc),
            ),
          )
        ],
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return FutureBuilder(
      future: getGroupChannels(),
      builder: (context, snapshot) {
        if (snapshot.hasData == false || snapshot.data == []) {
          // Nothing to display yet - good place for a loading indicator
          print('Data has not found');
          return Container();
        }

        return ListView.builder(
            itemCount: groupChannelList.length,
            itemBuilder: (context, index) {
              GroupChannel channel = groupChannelList[index];
              print(channel.name);
              return ListTile(
                title: Text(
                  [for (final member in channel.members) member.nickname].join(", "),
                ),
                subtitle: Text(channel.lastMessage?.message ?? ''),
              );
            });
      },
    );
  }

  void gotoChannel(String channelUrl) {
    GroupChannel.getChannel(channelUrl).then((channel) {
      Navigator.pushNamed(context, '/channel_list');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GroupChannelView(groupChannel: channel),
        ),
      );
    }).catchError((e) {
      print('channel_list_view: gotoChannel: ERROR: $e');
    });
  }

  Future<List<GroupChannel>> getGroupChannels() async {
    try {
      GroupChannelListQuery query = GroupChannelListQuery()
        ..includeEmptyChannel = true
        ..order = GroupChannelListOrder.latestLastMessage
        ..limit = 15;
      final res = await query.loadNext();
      groupChannelList.addAll(res);
      // print(groupChannelList.length);
      return res;
    } catch (e) {
      print('getGroupChannels: ERROR $e');
      return [];
    }
  }
}
