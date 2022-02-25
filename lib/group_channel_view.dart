import 'package:flutter/material.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';

class GroupChannelView extends StatefulWidget {
  final GroupChannel groupChannel;
  GroupChannelView({Key? key, required this.groupChannel}) : super(key: key);

  @override
  State<GroupChannelView> createState() => _GroupChannelViewState();
}

class _GroupChannelViewState extends State<GroupChannelView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
