import 'package:flutter/material.dart';
import 'package:myapp/resources/colors.dart';
import 'package:myapp/resources/dimentions.dart';

class CreateComment extends StatefulWidget {
  const CreateComment({super.key});

  @override
  State<CreateComment> createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {

  final _formKey = GlobalKey<FormState>();

  void _saveComment() {
    if (_formKey.currentState!.validate()) {
      
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Comment'),
        centerTitle: true
      ),
      body: Padding(
        padding: const EdgeInsets.all(extraLargeSize),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Comment Creator'),
                ), 
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(extraLargeSize)
                    ),
                    hintText: 'Insert Your Name',
                    prefixIcon: const Icon(Icons.person)
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    } else {
                      return null;
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Comment Text'),
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(extraLargeSize)
                    ),
                    hintText: 'Insert Comment Text',
                    prefixIcon: const Icon(Icons.notes)
                  ),
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Moment Creator';
                    }
                    return null;
                  },
                  minLines: 3,
                  maxLines: null,
                ),
                const SizedBox(height: largeSize,),
                ElevatedButton(
                  onPressed: _saveComment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white
                  ),
                  child: const Text('Send'),
                ),
                const SizedBox(height: mediumSize,),
                OutlinedButton(
                  onPressed: () {
                    // Navigasi ke halaman home
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          )),
      )
    );
  }
}