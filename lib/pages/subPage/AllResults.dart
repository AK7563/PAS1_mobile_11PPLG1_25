import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_25/utility/teamsModel.dart';

import '../../controllers/Controller.dart';
import '../../widgets/tile.dart';

class AllResults extends StatelessWidget {
  AllResults({
    super.key,
    this.isLike = false,
    this.isHome = true
  }){
    controller.loadLiked();
  }
  AllResults.isLiked({
    super.key,
    this.isLike = true,
    this.isHome = false
  }){
    controller.loadLiked();
  }

  final bool isLike;
  final bool isHome;
  final MyController controller = Get.find();
  List<teamsModel> get data => loadDB();

  loadDB() {
    if(isHome){
      controller.returnData = controller.search;
      return controller.returnData;
    }
    if(isLike){
      return controller.likedData;
    }
    else{
      return controller.fullList;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('I update');
    return Obx((){
        if(controller.isLoading.value){
          return LinearProgressIndicator();
        }
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              margin: const EdgeInsets.all(5),
              child: Card(
                child: myTile(
                  index: index,
                  isLiked: controller.checkLiked(data[index]),
                  imageURL: data[index].strBadge,
                  name: data[index].strTeam,
                  teamShort: data[index].strTeamShort,
                    onLike: () {
                    if(controller.checkLiked(data[index])){
                      controller.removeLiked(data[index]);
                    }
                    else{
                      controller.addLiked(data[index]);
                    }
                  }
                ),
              ),
            );
          }
        );
      });
  }
}
