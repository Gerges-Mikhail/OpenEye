import 'package:flutter/material.dart';
import 'package:open_eye/feature/data/model/notesModel.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';
class DataNoteCard extends StatelessWidget {
  const DataNoteCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  final NoteModel data;

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Title : ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data.title,overflow: TextOverflow.ellipsis),
            ],
          ),
        ],
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Text(
                'Note : ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(data.subtitle,overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Divider(color: primaryColor,),
        ],
      ),

    );
  }
}
