import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../models/Ticket_Model.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  // Event categories
  String? selectedCategory;
  final List<String> categories = [
    'Conference',
    'Workshop',
    'Seminar',
    'Networking',
    'Social',
    'Other'
  ];

  // Ticket types
  List<TicketType> ticketTypes = [];

  // Event settings
  bool isPrivateEvent = false;
  bool requiresRegistration = true;
  int? maxAttendees;
  DateTime? registrationDeadline;
  final _formKey = GlobalKey<FormState>();
  bool isOnlineEvent = false;
  XFile? mainImage;
  List<XFile> additionalImages = [];
  final ImagePicker _picker = ImagePicker();
  LatLng? selectedLocation;

  // Form controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final organizationController = TextEditingController();
  final hostController = TextEditingController();
  final meetingLinkController = TextEditingController();
  final locationController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  Future<void> _pickMainImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        mainImage = image;
      });
    }
  }

  Future<void> _pickAdditionalImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        additionalImages.addAll(images);
      });
    }
  }

  void _showAddTicketDialog({int? editIndex}) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final quantityController = TextEditingController();
    final descriptionController = TextEditingController();

    if (editIndex != null) {
      final ticket = ticketTypes[editIndex];
      nameController.text = ticket.name;
      priceController.text = ticket.price.toString();
      quantityController.text = ticket.quantity.toString();
      descriptionController.text = ticket.description ?? '';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(editIndex != null ? 'Edit Ticket' : 'Add Ticket'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Ticket Name'),
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity Available'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: descriptionController,
                decoration:
                    InputDecoration(labelText: 'Description (Optional)'),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final ticket = TicketType(
                name: nameController.text,
                price: double.tryParse(priceController.text) ?? 0,
                quantity: int.tryParse(quantityController.text) ?? 0,
                description: descriptionController.text.isEmpty
                    ? null
                    : descriptionController.text,
              );

              setState(() {
                if (editIndex != null) {
                  ticketTypes[editIndex] = ticket;
                } else {
                  ticketTypes.add(ticket);
                }
              });

              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Event'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Image Picker
              GestureDetector(
                onTap: _pickMainImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: mainImage != null
                      ? Image.asset(mainImage!.path, fit: BoxFit.cover)
                      : Center(child: Text('Tap to add main image')),
                ),
              ),
              SizedBox(height: 16),

              // Event Type Switch
              SwitchListTile(
                title: Text('Online Event'),
                value: isOnlineEvent,
                onChanged: (bool value) {
                  setState(() {
                    isOnlineEvent = value;
                  });
                },
              ),

              // Basic Event Details
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Event Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Event Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Organization and Host
              TextFormField(
                controller: organizationController,
                decoration:
                    InputDecoration(labelText: 'Created by Organization'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter organization name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: hostController,
                decoration: InputDecoration(labelText: 'Hosted by'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter host name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Online/Offline specific fields
              if (isOnlineEvent)
                TextFormField(
                  controller: meetingLinkController,
                  decoration: InputDecoration(labelText: 'Meeting Link'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter meeting link';
                    }
                    return null;
                  },
                )
              else
                Column(
                  children: [
                    TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(labelText: 'Location'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 200,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(0, 0),
                          zoom: 2,
                        ),
                        onTap: (LatLng location) {
                          setState(() {
                            selectedLocation = location;
                          });
                        },
                        markers: selectedLocation != null
                            ? {
                                Marker(
                                  markerId: MarkerId('selected_location'),
                                  position: selectedLocation!,
                                ),
                              }
                            : {},
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 16),

              // Date and Time
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: dateController,
                      decoration: InputDecoration(labelText: 'Date'),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if (date != null) {
                          dateController.text = date.toString().split(' ')[0];
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select date';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: timeController,
                      decoration: InputDecoration(labelText: 'Time'),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          timeController.text = time.format(context);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select time';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Event Category
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: InputDecoration(labelText: 'Event Category'),
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Event Settings
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Event Settings',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SwitchListTile(
                        title: Text('Private Event'),
                        subtitle:
                            Text('Only invited guests can view and register'),
                        value: isPrivateEvent,
                        onChanged: (bool value) {
                          setState(() {
                            isPrivateEvent = value;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: Text('Requires Registration'),
                        subtitle: Text('Attendees must register to join'),
                        value: requiresRegistration,
                        onChanged: (bool value) {
                          setState(() {
                            requiresRegistration = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Maximum Attendees (Optional)'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            maxAttendees = int.tryParse(value);
                          });
                        },
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Registration Deadline'),
                        onTap: () async {
                          final deadline = await showDatePicker(
                            context: context,
                            initialDate: registrationDeadline ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          if (deadline != null) {
                            setState(() {
                              registrationDeadline = deadline;
                            });
                          }
                        },
                        controller: TextEditingController(
                          text: registrationDeadline != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(registrationDeadline!)
                              : '',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Ticket Management
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ticket Types',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          ElevatedButton.icon(
                            icon: Icon(Icons.add),
                            label: Text('Add Ticket'),
                            onPressed: () {
                              _showAddTicketDialog();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      if (ticketTypes.isEmpty)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('No ticket types added yet'),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: ticketTypes.length,
                          itemBuilder: (context, index) {
                            final ticket = ticketTypes[index];
                            return ListTile(
                              title: Text(ticket.name),
                              subtitle: Text(
                                  '${ticket.price}\$ - ${ticket.quantity} available'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () =>
                                        _showAddTicketDialog(editIndex: index),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        ticketTypes.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Additional Images
              ElevatedButton(
                onPressed: _pickAdditionalImages,
                child: Text('Add Additional Images'),
              ),
              SizedBox(height: 8),
              if (additionalImages.isNotEmpty)
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: additionalImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Image.asset(
                          additionalImages[index].path,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Create event object and submit
                      final event = {
                        'title': titleController.text,
                        'description': descriptionController.text,
                        'isOnline': isOnlineEvent,
                        'organization': organizationController.text,
                        'host': hostController.text,
                        'date': dateController.text,
                        'time': timeController.text,
                        'mainImage': mainImage?.path,
                        'additionalImages':
                            additionalImages.map((e) => e.path).toList(),
                      };
                      if (isOnlineEvent) {
                        event['meetingLink'] = meetingLinkController.text;
                      } else {
                        event['location'] = locationController.text;
                        if (selectedLocation != null) {
                          event['coordinates'] = {
                            'latitude': selectedLocation!.latitude,
                            'longitude': selectedLocation!.longitude,
                          };
                        }
                      }
                      // TODO: Submit event to backend
                      print(event);
                    }
                  },
                  child: Text('Create Event'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    organizationController.dispose();
    hostController.dispose();
    meetingLinkController.dispose();
    locationController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }
}
