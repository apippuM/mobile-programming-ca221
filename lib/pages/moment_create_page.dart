import 'package:flutter/material.dart';
import 'package:myapp/models/moments.dart';
import 'package:myapp/resources/colors.dart';
import 'package:myapp/resources/dimentions.dart';
import 'package:nanoid2/nanoid2.dart';

class MomentCreatePage extends StatefulWidget {
  const MomentCreatePage({super.key, required this.onSaved});

  final Function(Moment newMoment) onSaved;

  @override
  State<MomentCreatePage> createState() => _MomentCreatePageState();
}

class _MomentCreatePageState extends State<MomentCreatePage> {
  // Buat object form global key
  final _formKey = GlobalKey<FormState>();
  final _dataMoment = {};

  // Form data save method
  void _saveMoment() {
    if (_formKey.currentState!.validate()) {
      // Saving the form data to _dataMoment
      _formKey.currentState!.save();
      // Create new object from form data
      final moment = Moment(
        id: nanoid(),
        momentDate: _dataMoment['momentDate'],
        creator: _dataMoment['creator'],
        location: _dataMoment['location'],
        imageUrl: _dataMoment['imageUrl'],
        caption: _dataMoment['caption'],
      );
      widget.onSaved(moment);
      // Navigasi ke halaman home
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Moment'),
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
                  child: Text('Moment Date'),
                ), 
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(extraLargeSize)
                    ),
                    hintText: 'Select Date',
                    prefixIcon: const Icon(Icons.calendar_month)
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter date time';
                    } else if (DateTime.tryParse(value) == null) {
                      return 'Please enter a valid date time in format yyyy-MM-dd';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataMoment['momentDate'] = DateTime.tryParse(newValue) ?? DateTime.now();
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Creator'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(extraLargeSize)
                    ),
                    hintText: 'Moment Creator',
                    prefixIcon: const Icon(Icons.person)
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Moment Creator';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataMoment['creator'] = newValue;
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Location'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(extraLargeSize)
                    ),
                    hintText: 'Moment Location',
                    prefixIcon: const Icon(Icons.location_on)
                  ),
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Moment Location';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataMoment['location'] = newValue;
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Image URL'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(extraLargeSize)
                    ),
                    hintText: 'Moment Image URL',
                    prefixIcon: const Icon(Icons.image)
                  ),
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Moment Image URL';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataMoment['imageUrl'] = newValue;
                    }
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Caption'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(extraLargeSize)
                    ),
                    hintText: 'Moment Description',
                    prefixIcon: const Icon(Icons.notes)
                  ),
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Moment Caption';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataMoment['caption'] = newValue;
                    }
                  },
                ),
                const SizedBox(height: largeSize,),
                ElevatedButton(
                  onPressed: _saveMoment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white
                  ),
                  child: const Text('Create Moment'),
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