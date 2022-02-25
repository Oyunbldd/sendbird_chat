import 'package:flutter/material.dart';
import 'package:sendbird_flutter_dashchat/group_channel_view.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class CreateChannelView extends StatefulWidget {
  @override
  State<CreateChannelView> createState() => _CreateChannelViewState();
}

class _CreateChannelViewState extends State<CreateChannelView> {
  final Set<User> _selectedUsers = {};
  final List<User> _availableUsers = [];
  Future<List<User>> getUsers() async {
    try {
      final query = ApplicationUserListQuery();
      List<User> users = await query.loadNext();
      return users;
    } catch (e) {
      print('create_channel_view: getUsers: ERROR $e');
      return [];
    }
  }

  Future<GroupChannel> createChannel(List<String> userIds) async {
    try {
      final params = GroupChannelParams()..userIds = userIds;
      final channel = await GroupChannel.createChannel(params);
      return channel;
    } catch (e) {
      print('createChannel: ERROR $e');
      throw e;
    }
  }

  @override
  void initState() {
    super.initState();
    getUsers().then((users) {
      setState(() {
        _availableUsers.clear();
        _availableUsers.addAll(users);
      });
    }).catchError((e) {
      print('initState:Error $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
