import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widget/custom_text_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextView(text: "Search Pages",fontWeight: FontWeight.w600,),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('This is the Search Page'),
      ),
    );
  }
}
