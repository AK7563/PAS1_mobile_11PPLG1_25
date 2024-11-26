import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/Controller.dart';
import '../../widgets/MyContainer.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key,});

  final MyController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.sizeOf(context).height / 30;
    double textSize = controller.textSize.value;
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                  ),
                  image: DecorationImage(image: NetworkImage(controller.backgroundPath.value.toString()), fit: BoxFit.cover)
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage(controller.imagePath.value), fit: BoxFit.fitHeight)
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: const Text('AK7563', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold))
                    )
                  ],
                )
              ),
              Expanded(
                child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: myContainer(
                    color: const Color(0xFFF6F7FD),
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.sizeOf(context).height,
                                  child: myContainer.button(
                                    function: null,
                                    margin: const EdgeInsets.all(5),
                                    child: Icon(Icons.settings, color: Colors.white, size: iconSize)
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.sizeOf(context).height,
                                  child: myContainer.button(
                                      function: (){},
                                      margin: const EdgeInsets.all(5),
                                      child: Icon(Icons.qr_code, color: Colors.white, size: iconSize)
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: MediaQuery.sizeOf(context).height,
                                  child: myContainer.button(
                                      function: null,
                                      margin: const EdgeInsets.all(5),
                                      child: Icon(Icons.notifications, color: Colors.white, size: iconSize)
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, size: iconSize),
                          title: Text('Profile Settings', style: TextStyle(fontSize: textSize)),
                        ),
                        ListTile(
                          leading: Icon(Icons.notifications, size: iconSize),
                          title: Text('Notifications', style: TextStyle(fontSize: textSize)),
                        ),
                        ListTile(
                          leading: Icon(Icons.qr_code, size: iconSize),
                          title: Text('Your QR Code', style: TextStyle(fontSize: textSize)),
                        )
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
