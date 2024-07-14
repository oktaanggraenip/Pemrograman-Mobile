import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = '';
  List<dynamic> _items = [];
  int? _editingId;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final data = await ApiService.fetchData();
      if (data != null) {
        setState(() {
          _items = data;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load data: Data is null';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _postData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.createData({
        'name': _nameController.text,
        'email': _emailController.text,
      });

      if (response) {
        _nameController.clear();
        _emailController.clear();
        _fetchData(); // Refresh data
      } else {
        setState(() {
          _errorMessage = 'Failed to create data';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to create data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.updateData(_editingId.toString(), {
        'name': _nameController.text,
        'email': _emailController.text,
      });

      if (response) {
        _nameController.clear();
        _emailController.clear();
        _editingId = null;
        _fetchData(); // Refresh data
      } else {
        setState(() {
          _errorMessage = 'Failed to update data';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to update data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteData(String id) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.deleteData(id);

      if (response) {
        _fetchData(); // Refresh data
      } else {
        setState(() {
          _errorMessage = 'Failed to delete data';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to delete data: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _setEditingData(Map<String, dynamic> item) {
    setState(() {
      _nameController.text = item['name'];
      _emailController.text = item['email'];
      _editingId = item['id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Flutter CRUD App'),
      backgroundColor: Colors.lightBlueAccent,
      leading: const Icon(Icons.book),
    ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed:
                              _editingId == null ? _postData : _updateData,
                          child: Text(
                              _editingId == null ? 'Add Data' : 'Update Data'),
                        ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemCount: _items.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(item['name']),
                            subtitle: Text(item['email']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _setEditingData(item),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () =>
                                      _deleteData(item['id'].toString()),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
