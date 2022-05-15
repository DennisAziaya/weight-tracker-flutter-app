import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker_app/models/weight_record.dart';
import 'package:weight_tracker_app/providers/weight_provider.dart';
import 'package:weight_tracker_app/widgets/add_weight_bottom_sheet.dart';
import 'package:weight_tracker_app/widgets/update_weight_bottom_sheet.dart';

import '../providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<WeightRecord>> getAllRecords;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _reFetchData() async {
    await Provider.of<WeightDataProvider>(context, listen: false).getRecords();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeightDataProvider>(context);
    List<WeightRecord> _allRecords = provider.dataRecord;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Tracker App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logoutUser();
            },
          )
        ],
      ),
      body: Container(
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: RefreshIndicator(
            onRefresh: () => _reFetchData(),
            child: _allRecords.isEmpty
                ? const Center(
                    child:
                        Center(child: Text('No records found, start adding')),
                  )
                : ListView.builder(
                    itemCount: _allRecords.length,
                    itemBuilder: (context, index) {
                      return WeightRecordTile(
                        weightTitle: _allRecords[index].weight,
                        date: DateFormat.yMMMMd('en_US')
                            .format(_allRecords[index].entryDate),
                        //date: _records[index].entryDate,
                        //DateFormat.yMMMMd('en_US').format();
                        onTapEdit: () {
                          //weightData.editRecord(_records[index].id);
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return UpdateWeightBottomSheet(
                                  recordId: _allRecords[index].id.toString(),
                                  weightValue: _allRecords[index].weight,
                                );
                              });
                        },
                        onTapDelete: () {
                          //weightData.removeRecord(_records[index].id);
                          showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm'),
                                  content: const Text(
                                      'Are you sure you want to delete?'),
                                  actions: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                        onPressed: () {
                                          Provider.of<WeightDataProvider>(
                                                  context,
                                                  listen: false)
                                              .removeRecord(_allRecords[index]
                                                  .id
                                                  .toString());
                                          Fluttertoast.showToast(
                                              msg: "Deleting record",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Delete',
                                          //style: TextStyle(color: Colors.red),
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Cancel',
                                          //style: TextStyle(color: Colors.blue),
                                        )),
                                  ],
                                );
                              });
                        },
                      );
                    }),
          )),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Weight'),
        icon: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return const AddWeightBottomSheet();
              });
        },
      ),
    );
  }
}

class WeightRecordTile extends StatelessWidget {
  String weightTitle;
  String date;
  Function() onTapDelete;
  Function() onTapEdit;

  WeightRecordTile({
    Key? key,
    required this.weightTitle,
    required this.date,
    required this.onTapDelete,
    required this.onTapEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        dense: true,
        leading: const Icon(
          Icons.scale_outlined,
          size: 22,
        ),
        title: Text("Weight : " + weightTitle.toString()),
        subtitle: Text(date.toString()),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          InkWell(
              onTap: onTapEdit,
              child: const Icon(Icons.edit, color: Colors.blue)),
          SizedBox(
            width: 15,
          ),
          InkWell(
              onTap: onTapDelete,
              child: const Icon(Icons.delete, color: Colors.red))
        ]),
      ),
    );
  }
}
