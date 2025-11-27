import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/chore_item.dart';
import '../models/chore_type.dart';
import '../providers/chore_provider.dart';

class CreateChoreScreen extends StatefulWidget {
  const CreateChoreScreen({super.key});

  @override
  State<CreateChoreScreen> createState() => _CreateChoreScreenState();
}

class _CreateChoreScreenState extends State<CreateChoreScreen> {
  final _titleController = TextEditingController();
  int _selectedPoints = 5;
  late List<ChoreType> _availableTypes;
  late ChoreType _selectedType;
  late List<int> _pointOptions;

  @override
  void initState() {
    super.initState();
    _availableTypes = ChoreHelper.loadAvailableTypes();
    _selectedType = _availableTypes.first;
    _pointOptions = ChoreHelper.loadAvailablePoints();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _createChore() {

    final newChore = ChoreItem(
      id: const Uuid().v4(),
      title: _titleController.text == '' ? _selectedType.title : _titleController.text,
      points: _selectedPoints,
      type: _selectedType,
    );

    Provider.of<ChoreProvider>(context, listen: false).addChore(newChore);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)], // Light blue to darker blue
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.cleaning_services, size: 28, color: Colors.black),
                              SizedBox(width: 8),
                              Text(
                                'CHORE CREATION',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Sans'),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Image.asset(
                              'assets/images/close_button.png',
                              width: 36,
                              height: 36,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Title Input
                      const Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('Title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Add title...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black, width: 1.5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Points
                      const Text('Points', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ..._pointOptions.map((points) {
                            final isSelected = _selectedPoints == points;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedPoints = points),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withValues(alpha: 0.5),
                                  border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withValues(alpha: 0.3),
                                      offset: const Offset(-2, -2),
                                      blurRadius: 5,
                                    ),
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.1),
                                      offset: const Offset(2, 2),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    '$points',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.black : Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          // Plus button placeholder
                           Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withValues(alpha: 0.5),
                              ),
                              child: const Icon(Icons.add, color: Colors.black),
                            ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Category & Icon Label
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: const Column(
                          children: [
                            Text('Category', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            Text('& Icon', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Icons List
                      SizedBox(
                        height: 100,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _availableTypes.length,
                          separatorBuilder: (context, index) => const SizedBox(width: 20),
                          itemBuilder: (context, index) {
                            final type = _availableTypes[index];
                            final isSelected = _selectedType == type;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedType = type),
                              child: Center(
                                child: Icon(
                                  type.icon,
                                  size: 72,
                                  color: isSelected ? const Color(0xFF0D47A1) : Colors.white.withValues(alpha: 0.5),
                                  shadows: isSelected ? [
                                    const Shadow(color: Colors.white, blurRadius: 15),
                                    const Shadow(color: Colors.white, blurRadius: 15),
                                  ] : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 80), // Space for Floating Action Button
                    ],
                  ),
                ),
              ),
              // Floating Action Button
              Positioned(
                bottom: 30,
                right: 30,
                child: GestureDetector(
                  onTap: _createChore,
                  child: Image.asset(
                    'assets/images/create_chore_btn.png',
                    width: 64,
                    height: 64,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
