import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/moments.dart';
import 'package:myapp/resources/colors.dart';
import 'package:myapp/resources/dimentions.dart';
import 'package:nanoid2/nanoid2.dart';

class MomentEntryPage extends StatefulWidget {
  const MomentEntryPage({
    super.key, 
    required this.onSaved,
    this.selectedMoment});

  final Function(Moment newMoment) onSaved;
  final Moment? selectedMoment;

  @override
  State<MomentEntryPage> createState() => _MomentEntryPageState();
}

class _MomentEntryPageState extends State<MomentEntryPage> {
  // Buat object form global key
  final _formKey = GlobalKey<FormState>();
  final _dataMoment = {};

  // Text Editing Controller
  final _momentDateController = TextEditingController();
  final _creatorController = TextEditingController();
  final _locationController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _captionController = TextEditingController();
  final _dateFormat = DateFormat('yyyy-MM-dd');
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.selectedMoment != null) {
      final selectedMoment = widget.selectedMoment!;
      _momentDateController.text = _dateFormat.format(selectedMoment.momentDate);
      _creatorController.text = selectedMoment.creator;
      _locationController.text = selectedMoment.location;
      _imageUrlController.text = selectedMoment.imageUrl;
      _captionController.text = selectedMoment.caption;
      _selectedDate = selectedMoment.momentDate;
    } else {
      _selectedDate = DateTime.now();
    }
  }

  // Form data save method
  void _saveMoment() {
    if (_formKey.currentState!.validate()) {
      // Saving the form data to _dataMoment
      _formKey.currentState!.save();
      // Create new object from form data
      final moment = Moment(
        id: widget.selectedMoment?.id ?? nanoid(),
        momentDate: _dataMoment['momentDate'],
        creator: _dataMoment['creator'],
        location: _dataMoment['location'],
        imageUrl: _dataMoment['imageUrl'],
        caption: _dataMoment['caption'],
        likeCount: widget.selectedMoment?.likeCount ?? 0,
        commentCount: widget.selectedMoment?.commentCount ?? 0,
        bookmarkCount: widget.selectedMoment?.bookmarkCount ?? 0
      );
      widget.onSaved(moment);
      // Navigasi ke halaman home
      Navigator.of(context).pop();
    }
  }

  void _pickDate() async {
    final todayDate = DateTime.now();
    final firstDate = todayDate.subtract(const Duration(days: 365));
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: todayDate,
      initialDate: _selectedDate.isAfter(todayDate) ? null :_selectedDate,
    );
    if (selectedDate != null) {
        setState(() {
          _momentDateController.text = _dateFormat.format(selectedDate);
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.selectedMoment == null ? 'Create' : 'Update'} Moment'),
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
                  controller: _momentDateController,
                  onTap: _pickDate,
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
                  controller: _creatorController,
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
                  controller: _locationController,
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
                  controller: _imageUrlController,
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
                  controller: _captionController,
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
                  child: Text(
                    widget.selectedMoment == null ? 'Save' : 'Update'),
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