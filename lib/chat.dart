import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  List<String> _messages = [];

  void _handleSubmitted(String text) {
    _textEditingController.clear();

    setState(() {
      _messages.insert(0, text);
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textEditingController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textEditingController.text),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (_, int index) => _buildMessage(_messages[index]),
      ),
    );
  }

  Widget _buildMessage(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: Text("User")),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("User", style: Theme.of(context).textTheme.subtitle1),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
        backgroundColor: Color(0xFFF23F44),
      ),
      body: Column(
        children: <Widget>[
          _buildMessageList(),
          Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
    );
  }
}
