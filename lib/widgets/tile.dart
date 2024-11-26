import 'package:flutter/material.dart';

import 'MyContainer.dart';

class myTile extends StatelessWidget {
  const myTile({
    super.key,
    required this.index,
    required this.name,
    required this.teamShort,
    required this.onLike,
    required this.imageURL,
    required this.isLiked
  });

  final bool isLiked;
  final int index;
  final String imageURL;
  final String name;
  final String teamShort;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (Image.network(imageURL)),
      title: Text(name),
      titleTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.lightBlueAccent,
          fontWeight: FontWeight.w600),
      subtitle: Text("Short: $teamShort"),
      dense: true,
      trailing: IconButton(
          onPressed: onLike,
          icon: isLiked ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border)
      ),
      onTap: (){},
    );
  }
}

class myOtherTile extends StatelessWidget {
  const myOtherTile({
    super.key,
    required this.index,
    required this.name,
    required this.addedDate,
    required this.onRemove,
    required this.onTap,
    required this.count,
    required this.len
  });

  final num count;
  final num len;
  final int index;
  final String name;
  final String addedDate;
  final VoidCallback onRemove;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Colors.blue)
          )
        )
      ),
      onPressed: onTap,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.w600
                  )
                ),
                Text(addedDate)
              ],
            )
          ),
          Expanded(
            child: Text('${count}/${len}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.w600
              )
            )
          ),
          myContainer.button(
            function: (){
              showDialog(
                context: context,
                builder: (context)=>
                  AlertDialog(
                    title: const Text('Are You Sure?'),
                    content: const Text('Removing your task will remove its progress forever'),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')
                      ),
                      TextButton(
                        onPressed: onRemove,
                          child: const Text('Remove')
                        )
                      ],
                  )
              );
            },
            child: Row(
              children: [
                Expanded(child: Container()),
                const Text('Remove', style: TextStyle(color: Colors.white)),
                Expanded(child: Container())
              ],
            )
          )
        ],
      ),
    );
  }
}

