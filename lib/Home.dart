import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  @override
  void initState() {
    _checkFirstRun();
    super.initState();


  }


  void _checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    final isFirstRun = prefs.getString('phoneNumber') ?? '';
    if (isFirstRun == '') {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder:
            (context) => AlertDialog(
              icon: Icon(Icons.phone),
              iconColor: Colors.yellow[400],
              backgroundColor: Colors.grey[900],
              content: Form(
                key: _formKey,
                child: TextFormField(
                  cursorColor: Colors.black,
                  controller: _phoneNumberController,
                  style: TextStyle(color: Colors.yellow[400]),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number.';
                    } else if (value.length != 11 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Invalid phone number. Must be 11 digits and contain only numbers.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.yellow[400],
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),)
                  ),
                ),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Set background color
                    ),
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        await prefs.setString('phoneNumber', _phoneNumberController.text);
                        setState(() {
                          _phoneNumberController.text = prefs.getString('phoneNumber')!;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Phone number saved successfully!'),
                          ),
                        );
                      }
                    },
                    child: Text('Save',style: TextStyle(color: Colors.yellow[400],),
                  ),
                  )],
      )
      );
    }else{
      setState(() {
        _phoneNumberController.text = prefs.getString('phoneNumber')!;
      });
    }
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("MR Muscle"),
        backgroundColor: Colors.yellow[400],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[400],
        onPressed:()async {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.remove('phoneNumber');
          _checkFirstRun();

        },
        child: Icon(Icons.lock_reset_outlined,color: Colors.black,),

      ),
      body:
      Container(
        color: Colors.black,
        child:
        _phoneNumberController.text != '' // Check if prefs is initialized before accessing it
            ? Container(

          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _phoneNumberController.text.isNotEmpty // Use null-safe accessors
                  ? QrImageView(
                data: _phoneNumberController.text, // Use ! for non-null access after checking
                backgroundColor: Colors.yellow,
                embeddedImage: AssetImage('assets/logo.jpg'),
              )
                  : Text(""),
            ],
          ),
      )
      : Center(child: CircularProgressIndicator()), // Show loading indicator while waiting
    ));
  }
}
