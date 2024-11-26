import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import '../controllers/Controller.dart';
import '../widgets/MyContainer.dart';
import '../widgets/PopDialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  final MyController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.textSize = (15.0 * MediaQuery.sizeOf(context).height/600).obs;
    double textSize = controller.textSize.value;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.sports_soccer, color: Colors.black, size: MediaQuery.sizeOf(context).width / 5,),
              Text("Welcome To Ligeo", style: TextStyle(fontSize: textSize*2),textAlign: TextAlign.center),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 100,
                child: Text("The application to see sport statistics", textAlign: TextAlign.center, style: TextStyle(fontSize: textSize/1.2)),
              ),

              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Insert Username', style: TextStyle(fontSize: textSize))
                ),
              ),
              myContainer(child: TextField(
                controller: username,
                maxLines: 1,
                style: TextStyle(fontSize: textSize),
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Insert username',
                ),
              )),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Insert Password', style: TextStyle(fontSize: textSize))
                ),
              ),
              myContainer(child: TextField(
                controller: password,
                maxLines: 1,
                style: TextStyle(fontSize: textSize),
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Insert password',
                ),
              )),
              myContainer.button(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      Text('Log In', style: TextStyle(color: Colors.white, fontSize: textSize*1.5)),
                      Expanded(child: Container())
                    ],
                  ),
                  function:() async {
                    showDialog(
                        context: context,
                        builder: (context)=>const AlertDialog(
                          title: Text('Loading'),
                          content: SizedBox(
                              height: 2,
                              child: LinearProgressIndicator()
                          ),
                        )
                    );
                    await controller.logIn(username.text, password.text);
                    print(controller.logInResponse);
                    Navigator.pop(context);
                    if(controller.logInResponse.value.status){
                      controller.fetchFull();
                      showDialog(
                          context: context,
                          builder: (context)=>myPopUp(
                            title: 'Login Successful',
                            content: 'And your token is: ${controller.logInResponse.value.token}',
                            action: 'OK',
                            onPress: (){
                              Get.toNamed("/home");
                              return;
                            },
                          )
                      );
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (context)=>myPopUp(
                          title: 'Login Not Successful',
                          content: '${controller.logInResponse.value.message}',
                          action: 'OK',
                          onPress: ()=>Navigator.pop(context),
                        )
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
