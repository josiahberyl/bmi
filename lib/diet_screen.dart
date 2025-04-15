import 'package:flutter/material.dart';

class DietScreen extends StatelessWidget {
  final List<Map<String, dynamic>> diets = [
    {
    "title": "Animal-Based Diet",
    "image":
        "https://images.unsplash.com/photo-1604909052934-3b52c31c7e95?auto=format&fit=crop&w=800&q=80"
  },
  {
    "title": "High Protein Diet",
    "image":
        "https://images.unsplash.com/photo-1606788075763-0e9298f97a7f?auto=format&fit=crop&w=800&q=80"
  },
  {
    "title": "Low Calorie Diet",
    "image":
        "https://images.unsplash.com/photo-1584270354949-1c7a5d0388e4?auto=format&fit=crop&w=800&q=80"
  },
  {
    "title": "Keto Diet",
    "image":
        "https://images.unsplash.com/photo-1606755962771-25c4b40e2397?auto=format&fit=crop&w=800&q=80"
  },
  {
    "title": "Mediterranean Diet",
    "image":
        "https://images.unsplash.com/photo-1613145995935-1a53df2627e3?auto=format&fit=crop&w=800&q=80"
  },
  {
    "title": "Plant-Based Diet",
    "image":
        "https://images.unsplash.com/photo-1584270354701-8fdede0d3664?auto=format&fit=crop&w=800&q=80"
  },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Choose Your Diet"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: diets.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final diet = diets[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: InkWell(
                onTap: () {
                  // Add tap functionality here
                },
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        diet["image"],
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            diet["title"],
                            style: TextStyle(
                              color: Colors.cyanAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
