import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; 
import 'OptionMenuChat.dart';     

void main() {
  runApp(new ChatApp());
}


class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Chat Screen",
      debugShowCheckedModeBanner: false,                                        //new
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Messaging Screen")
        ),
    );
  }
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{                  //new
  @override                                                        //new
  Widget build(BuildContext context) {
  return new Scaffold(
   appBar: AppBar(
        title: Text('Tejas',
            style: TextStyle(
              letterSpacing: -1,
              color: Colors.grey[800],
            )),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                Icons.search,
                color: Colors.grey[800],
              )),
          Container(
            child: OptionMenuChat(),
          )
        ],
      ),
    body: new Container(                                             //modified
        child: new Column(                                           //modified
          children: <Widget>[
            new Flexible(
              child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS //new
            ? new BoxDecoration(                                     //new
                border: new Border(                                  //new
                  top: new BorderSide(color: Colors.grey[200]),      //new
                ),                                                   //new
              )                                                      //new
            : null),                                                 //modified
  );
}
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;  
  Widget _buildTextComposer() {
  return new IconTheme(
    data: new IconThemeData(color: Theme.of(context).accentColor),
    child: new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new TextField(
              controller: _textController,
              onChanged: (String text) {          //new
                setState(() {                     //new
                  _isComposing = text.length > 0; //new
                });                               //new
              },                                  //new
              onSubmitted: _handleSubmitted,
              decoration:
                  new InputDecoration.collapsed(hintText: "Send a message"),
            ),
          ),
          new Container(
   margin: new EdgeInsets.symmetric(horizontal: 4.0),
   child: Theme.of(context).platform == TargetPlatform.iOS ?  //modified
   new CupertinoButton(                                       //new
     child: new Text("Send"),                                 //new
     onPressed: _isComposing                                  //new
         ? () =>  _handleSubmitted(_textController.text)      //new
         : null,) :                                           //new
   new IconButton(                                            //modified
       icon: new Icon(Icons.send),
       onPressed: _isComposing ?
           () =>  _handleSubmitted(_textController.text) : null,
       )
   ),
        ],
      ),
    ),
  );
}

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {                                                    //new
      _isComposing = false;                                          //new
    });                                                              //new
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }
  void dispose() {                                                   //new
    for (ChatMessage message in _messages)                           //new
      message.animationController.dispose();                         //new
    super.dispose();                                                 //new
  }

}

const String _name = "You";

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return new SizeTransition(                                    //new
    sizeFactor: new CurvedAnimation(                              //new
        parent: animationController, curve: Curves.easeOut),      //new
    axisAlignment: 0.0,                                           //new
    child: new Container(                                    //modified
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(child: new Text(_name[0])),
            ),
            new Expanded(                                               //new
              child: new Column(                                   //modified
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(_name, style: Theme.of(context).textTheme.subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(text),
                  ),
                ],
              ),
            ),   
          ],
        ),
      )                                                           //new
    );
  }
}


