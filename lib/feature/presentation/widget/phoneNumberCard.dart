import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:open_eye/feature/data/model/phoneNumberModel.dart';
import 'package:open_eye/feature/presentation/common/colors/colors.dart';

class PhoneNumberCard extends StatelessWidget {
  PhoneNumberCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);
  final PhoneNumberModel data;
  List<PhoneNumberModel> datas = [];
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 22.2,
            backgroundColor: primaryColor,
            child: CircleAvatar(
                backgroundColor: white,
                child: Text(
                  data.name[0].toUpperCase(),
                  style: const TextStyle(color: primaryColor, fontSize: 25),
                )),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: CircleAvatar(
              backgroundColor: white,
              radius: 10,
              child: Icon(
                Icons.favorite,
                color: primaryColor,
              ),
            ),
          )
        ],
      ),
      title: Text(
        data.name,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Text(
        data.phoneNumber,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
              onTap: ()=> call(datas[index].phoneNumber),
              child: const CircleAvatar(
            backgroundColor: white,
            child: Icon(
              Icons.call,
              color: green,
              size: 25,
            ),
          )),
          GestureDetector(
              // onTap: pressDelete as void Function()?,
              child: const CircleAvatar(
            backgroundColor: white,
            child: Icon(
              Icons.delete,
              color: red,
              size: 25,
            ),
          )),
        ],
      ),
    );
  }

  call(String phoneNumber) async {
    String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
