import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final List<String> previousDiagnoses = [];

  SearchWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String query = '';
  List<String> filteredDiagnoses = [];

  @override
  void initState() {
    super.initState();
    filteredDiagnoses = widget.previousDiagnoses;
  }

  void updateSearch(String value) {
    setState(() {
      query = value;
      filteredDiagnoses =
          widget.previousDiagnoses
              .where(
                (diagnosis) =>
                    diagnosis.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search previous diagnoses',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: updateSearch,
          ),
        ),
        Expanded(
          child:
              filteredDiagnoses.isEmpty
                  ? Center(child: Text('No diagnoses found.'))
                  : ListView.builder(
                    itemCount: filteredDiagnoses.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(filteredDiagnoses[index]));
                    },
                  ),
        ),
      ],
    );
  }
}
