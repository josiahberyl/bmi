import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _calorieController = TextEditingController();

  List<Map<String, dynamic>> _mandatoryWorkouts = [
    {"name": "Jumping Jacks", "done": false, "calories": 100},
    {"name": "Push Ups", "done": false, "calories": 150},
    {"name": "Plank", "done": false, "calories": 120},
    {"name": "Squats", "done": false, "calories": 180},
  ];

  List<Map<String, dynamic>> _customWorkouts = [];

  int get totalCalories => [..._mandatoryWorkouts, ..._customWorkouts]
      .where((w) => w['done'])
      .fold(0, (sum, w) => sum + (int.tryParse(w['calories'].toString()) ?? 0));

  int get totalCompleted => [..._mandatoryWorkouts, ..._customWorkouts]
      .where((w) => w['done'])
      .length;

  int get totalWorkouts => _mandatoryWorkouts.length + _customWorkouts.length;

  void _addWorkout() {
    final name = _nameController.text.trim();
    final calories = int.tryParse(_calorieController.text.trim());

    if (name.isNotEmpty && calories != null) {
      setState(() {
        _customWorkouts.add({
          "name": name,
          "done": false,
          "calories": calories,
        });
      });
      _nameController.clear();
      _calorieController.clear();
    }
  }

  void _toggleDone(int index, bool isCustom) {
    setState(() {
      if (isCustom) {
        _customWorkouts[index]['done'] = !_customWorkouts[index]['done'];
      } else {
        _mandatoryWorkouts[index]['done'] = !_mandatoryWorkouts[index]['done'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade700,
        title: const Text("Workout To-Do"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: totalWorkouts == 0 ? 0 : totalCompleted / totalWorkouts,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
            ),
            const SizedBox(height: 8),
            Text(
              "Calories Burned: $totalCalories",
              style: const TextStyle(color: Colors.cyanAccent, fontSize: 18),
            ),
            const SizedBox(height: 16),

            // Input Section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Workout Name",
                      labelStyle: TextStyle(color: Colors.cyanAccent),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyanAccent)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _calorieController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Cal",
                      labelStyle: TextStyle(color: Colors.cyanAccent),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyanAccent)),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.cyanAccent),
                  onPressed: _addWorkout,
                )
              ],
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  const Text("Mandatory Workouts",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ..._mandatoryWorkouts
                      .asMap()
                      .entries
                      .map((entry) => _buildWorkoutTile(entry.value, entry.key, false))
                      .toList(),
                  const SizedBox(height: 16),
                  const Text("Custom Workouts",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ..._customWorkouts
                      .asMap()
                      .entries
                      .map((entry) => _buildWorkoutTile(entry.value, entry.key, true))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutTile(Map<String, dynamic> workout, int index, bool isCustom) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        title: Text(
          workout['name'],
          style: TextStyle(
            color: workout['done'] ? Colors.greenAccent : Colors.white,
            decoration: workout['done'] ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text("${workout['calories']} cal",
            style: const TextStyle(color: Colors.cyanAccent)),
        trailing: Checkbox(
          value: workout['done'],
          onChanged: (_) => _toggleDone(index, isCustom),
          activeColor: Colors.cyanAccent,
        ),
      ),
    );
  }
}
