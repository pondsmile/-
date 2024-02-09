import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RemoveAlertDialog extends StatefulWidget {
  const RemoveAlertDialog({
    Key? key,
    required this.title,
    required this.description,
    // ignore: non_constant_identifier_names
    required this.licenses_key,
  }) : super(key: key);

  // ignore: non_constant_identifier_names
  final String? title, description, licenses_key;

  @override
  _RemoveAlertDialogState createState() => _RemoveAlertDialogState();
}

class _RemoveAlertDialogState extends State<RemoveAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(
            "${widget.title}",
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Text(
                "${widget.description}",
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            height: 1,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: InkWell(
              highlightColor: Colors.grey[200],
              onTap: () {
                FirebaseDatabase.instance
                    .reference()
                    .child('user/' + widget.licenses_key!)
                    .remove()
                    .then((_) {
                      
                  Navigator.of(context).pop();
                });
              },
              child: const Center(
                child: Text(
                  "ลบ",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: InkWell(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              highlightColor: Colors.grey[200],
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Center(
                child: Text(
                  "ยกเลิก",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
