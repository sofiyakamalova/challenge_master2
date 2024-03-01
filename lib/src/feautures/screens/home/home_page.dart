import 'package:challenge_master/src/components/build_text_field.dart';
import 'package:challenge_master/src/core/common_widgets/common_title.dart';
import 'package:challenge_master/src/core/constants/app_color.dart';
import 'package:challenge_master/src/feautures/screens/home/widgets/search_widget.dart';
import 'package:challenge_master/src/feautures/screens/home/widgets/spinning_wheel.dart';
import 'package:challenge_master/src/provider/library_provider.dart';
import 'package:challenge_master/src/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropDownValue = 'sport';
  late LibraryProvider libProvider; // Declare a LibraryProvider variable

  //sign out function
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

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
        "category": item["category"],
      };
    }).toList();
    setState(() {
      _items = data.reversed.toList();
      print(_items.length);
    });
  }

  //new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    String selectedCategory = dropDownValue;
    // Добавляем категорию к данным
    newItem["category"] = selectedCategory;
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
    if (itemKey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemKey);
      _titleController.text = existingItem['title'];
      _subtitleController.text = existingItem['subtitle'];
    }

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              BuildTextField(
                  hintText: 'Enter a title',
                  controller: _titleController,
                  obscureText: false),
              const SizedBox(height: 10),
              BuildTextField(
                controller: _subtitleController,
                obscureText: false,
                hintText: 'Enter a subtitle',
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
                value: dropDownValue,
                icon: const Icon(Icons.menu),
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValue = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: "sport",
                    child: Text('Sport'),
                  ),
                  DropdownMenuItem(
                    value: "dance",
                    child: Text('Dance'),
                  ),
                  DropdownMenuItem(
                    value: "music",
                    child: Text('Music'),
                  ),
                  DropdownMenuItem(
                    value: "science",
                    child: Text('Science'),
                  ),
                  DropdownMenuItem(
                    value: "social",
                    child: Text('Social'),
                  ),
                  DropdownMenuItem(
                    value: "reading",
                    child: Text('Reading'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (itemKey == null) {
                    _createItem({
                      "title": _titleController.text,
                      "subtitle": _subtitleController.text,
                    });
                  }
                  if (itemKey != null) {
                    _updateItem(itemKey, {
                      'title': _titleController.text.trim(),
                      'subtitle': _subtitleController.text.trim(),
                    });
                  }

                  //clear textFields
                  _titleController.text = '';
                  _subtitleController.text = '';
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColor.whiteColor,
                  backgroundColor: AppColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  itemKey == null ? 'Create New' : 'Update',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        toolbarHeight: 60,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonTitle(
                title: 'Challenge Master',
                size: 30,
              ),
              IconButton(
                onPressed: signOut,
                icon: const Icon(
                  Icons.logout,
                  color: AppColor.secondMainColor,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              const SearchWidget(),
              const CommonTitle(
                title: 'Exhaust yourself with new challenges!',
                alignment: TextAlign.center,
                size: 25,
              ),
              const SpinningWheel(),
              const SizedBox(height: 10.0),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const CommonTitle(
                        title: 'Challenges', textColor: AppColor.mainTextColor),
                    DropdownButton<String>(
                      value: dropDownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                        });
                      },
                      items: [
                        "sport",
                        "dance",
                        "music",
                        "science",
                        "social",
                        "reading"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColor.primaryColor),
              Expanded(
                child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (_, index) {
                      final currentItem = _items[index];
                      return Card(
                        color: AppColor.secondMainColor,
                        margin: EdgeInsets.all(16.0),
                        elevation: 3,
                        child: ListTile(
                          title: Text(
                            currentItem['title'].toString(),
                            style: const TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentItem['subtitle'].toString(),
                                style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 20,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text("${currentItem['category']}"),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              //Editbutton
                              IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: AppColor.whiteColor),
                                  onPressed: () =>
                                      _showForm(context, currentItem['key'])),

                              // Delete button
                              IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: AppColor.whiteColor),
                                  onPressed: () =>
                                      _deleteItem(currentItem['key'])),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm(context, null);
        },
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}
