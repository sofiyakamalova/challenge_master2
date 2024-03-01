import 'package:challenge_master/src/components/build_text_field.dart';
import 'package:challenge_master/src/core/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';

class CreateChallengeWidget extends StatefulWidget {
  const CreateChallengeWidget({super.key});

  @override
  State<CreateChallengeWidget> createState() => _CreateChallengeWidgetState();
}

class _CreateChallengeWidgetState extends State<CreateChallengeWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  List<Map<String, dynamic>> _items = [];

  final _itemBox = Hive.box('my_challenges');

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  void _refreshItems() {
    final data = _itemBox.keys.map((key) {
      final item = _itemBox.get(key);
      return {
        "key": key,
        "title": item["title"],
        "subtitle": item["subtitle"],
      };
    }).toList();
    setState(() {
      _items = data.reversed.toList();
      print(_items.length);
    });
  }

  //new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _itemBox.add(newItem);
    _refreshItems();
  }

  //update item
  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _itemBox.put(itemKey, item);
    _refreshItems();
  }

  //delete item
  Future<void> _deleteItem(int itemKey) async {
    await _itemBox.delete(itemKey);
    _refreshItems();
    //Display SnackBar
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('An Item has been deleted')));
  }

  void _showForm(BuildContext ctx, int? itemKey) async {
    showModalBottomSheet(
      backgroundColor: AppColor.whiteColor,
      context: ctx,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          top: 15,
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            BuildTextField(
                controller: _titleController,
                hintText: 'Enter a title',
                obscureText: false),
            const SizedBox(height: 10),
            BuildTextField(
                controller: _subtitleController,
                hintText: 'Description of the challenge',
                obscureText: false),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColor.whiteColor,
                    backgroundColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    //clear textFields
                    _titleController.text = '';
                    _subtitleController.text = '';
                    Navigator.of(context).pop();
                  },
                  child: const Text('Create', style: TextStyle(fontSize: 20))),
            ),
            const SizedBox(height: 400),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _showForm(context, null);
      },
      icon: const Icon(
        Iconsax.add5,
        color: AppColor.primaryColor,
        size: 45,
      ),
    );
  }
}
