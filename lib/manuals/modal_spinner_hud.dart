//modal_progress_hud
//
//A simple widget wrapper to enable modal progress HUD (a modal progress indicator, HUD = Heads Up Display)
//
//pub package Build Status Coverage Status
//
//Inspired by this article.
//Demo
//
//Demo
//
//See example for details
//Usage
//
//Add the package to your pubspec.yml file.
//
//dependencies:
//modal_progress_hud: ^0.1.3
//
//Next, import the library into your widget.
//
//import 'package:modal_progress_hud/modal_progress_hud.dart';
//
//Now, all you have to do is simply wrap your widget as a child of ModalProgressHUD, typically a form, together with a boolean that is maintained in local state.
//
//...
//bool _saving = false
//...
//
//@override
//Widget build(BuildContext context) {
//  return Scaffold(
//    body: ModalProgressHUD(child: Container(
//        Form(...)
//    ), inAsyncCall: _saving),
//  );
//}
//
//Options
//
//The current parameters are customizable in the constructor
//
//ModalProgressHUD(
//@required inAsyncCall: bool,
//@required child: Widget,
//opacity: double,
//color: Color,
//progressIndicator: CircularProgressIndicator,
//offset: double
//dismissible: bool,
//);
//
//Example
//
//Here is an example app that demonstrates the usage.
//
//On initial load, _saving is false which causes your child widget to display
//When the form is submitted, _saving is set to true, which will display the modal
//Once the async call is complete, _saving is set back to false, hiding the modal
//
//class SettingsPage extends StatefulWidget {
//  @override
//  _SettingsPageState createState() => new _SettingsPageState();
//}
//
//class _SettingsPageState extends State<SettingsPage> {
//  bool _saving = false;
//
//  void _submit() {
//
//    setState(() {
//      _saving = true;
//    });
//
//    //Simulate a service call
//    print('submitting to backend...');
//    new Future.delayed(new Duration(seconds: 4), () {
//      setState(() {
//        _saving = false;
//      });
//    });
//  }
//
//  Widget _buildWidget() {
//    return new Form(
//      child: new Column(
//        children: [
//          new SwitchListTile(
//            title: const Text('Bedroom'),
//            value: _bedroom,
//            onChanged: (bool value) {
//              setState(() {
//                _bedroom = value;
//              });
//            },
//            secondary: const Icon(Icons.hotel),
//          ),
//          new RaisedButton(
//            onPressed: _submit,
//            child: new Text('Save'),
//          ),
//        ],
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('Flutter Progress Indicator Demo'),
//        backgroundColor: Colors.blue,
//      ),
//      body: ModalProgressHUD(child: _buildWidget(), inAsyncCall: _saving),
//    );
//  }
//}
//
