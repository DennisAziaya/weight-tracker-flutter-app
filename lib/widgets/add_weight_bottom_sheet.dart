import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/models/weight_record.dart';
import 'package:weight_tracker_app/providers/weight_provider.dart';

class AddWeightBottomSheet extends StatefulWidget {
  // TextEditingController weightController;
  // Function recordWeightCallBack;
  const AddWeightBottomSheet({Key? key}) : super(key: key);

  @override
  _AddWeightBottomSheetState createState() => _AddWeightBottomSheetState();
}

class _AddWeightBottomSheetState extends State<AddWeightBottomSheet> {
  final TextEditingController _weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _weightController.dispose();
  }

  late String newRecord;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: const BoxDecoration(color: Colors.white70),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                // onChanged: (newWeightRecord) {
                //   newRecord = newWeightRecord;
                // },
                validator: (val) =>
                    val!.isEmpty ? "Field cannot be left blank" : null,
                controller: _weightController,
                decoration: const InputDecoration(
                  hintText: "Weight(kgs)",
                  hintStyle: TextStyle(
                      letterSpacing: 0.1,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide(color: Colors.grey, width: 1.2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1.2)),
                  prefixIcon: Icon(
                    Icons.scale_outlined,
                    size: 22,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (!form!.validate()) {
                      return;
                    }

                    Fluttertoast.showToast(
                        msg: "Adding record",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    // setState(() {
                    //   newRecord = _weightController.text;
                    // });
                    // print(newRecord);
                    //Navigator.pop();

                    // String createdAt =
                    //     DateFormat.yMMMMd('en_US').format(DateTime.now());
                    String createdAt = DateTime.now().toString();

                    newRecord = _weightController.text;
                    Provider.of<WeightDataProvider>(context, listen: false)
                        .addRecords(newRecord, createdAt);
                    //.addRecord(newRecord);
                    // Provider.of<WeightDataProvider>(context, listen: false)
                    //     .getRecords();
                    Navigator.pop(context);
                  },
                  child: const Text('Add')),
            )
          ],
        ),
      ),
    );
  }
}
