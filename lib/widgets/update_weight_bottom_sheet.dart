import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/models/weight_record.dart';
import 'package:weight_tracker_app/providers/weight_provider.dart';

class UpdateWeightBottomSheet extends StatefulWidget {
  String weightValue;
  String recordId;
  UpdateWeightBottomSheet(
      {Key? key, required this.weightValue, required this.recordId})
      : super(key: key);

  @override
  State<UpdateWeightBottomSheet> createState() =>
      _UpdateWeightBottomSheetState();
}

class _UpdateWeightBottomSheetState extends State<UpdateWeightBottomSheet> {
  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _weightController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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
              padding: EdgeInsets.all(4.0),
              child: TextFormField(
                // onChanged: (newWeightRecord) {
                //   newRecord = newWeightRecord;
                // },
                validator: (val) =>
                    val!.isEmpty ? "Field cannot be left blank" : null,
                controller: _weightController,
                decoration: InputDecoration(
                  hintText: widget.weightValue,
                  hintStyle: const TextStyle(
                      letterSpacing: 0.1,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide(color: Colors.grey, width: 1.2)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1.2)),
                  prefixIcon: const Icon(
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

                    newRecord = _weightController.text;
                    Provider.of<WeightDataProvider>(context, listen: false)
                        .updateRecords(newRecord, widget.recordId);
                    //.addRecord(newRecord);
                    Fluttertoast.showToast(
                        msg: "Updating the record",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.pop(context);
                  },
                  child: const Text('Update')),
            )
          ],
        ),
      ),
    );
  }
}
