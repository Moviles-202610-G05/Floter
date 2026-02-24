import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.restaurant_menu, color: Colors.orange[800]),
            const SizedBox(width: 8),
            const Text('FoodGram', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // --- SECCIÓN PERFIL ---
              const CircleAvatar(
                radius: 60,
                backgroundColor: Color(0xFFFF6347),
                child: CircleAvatar(
                  radius: 56,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255), 
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Alex Johnson',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,  
                children: [
                  Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                  Text(' London, UK', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 24),

              // --- ESTADÍSTICAS ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard("42", "ORDERS"),
                  _buildStatCard("15", "REVIEWS"),
                  _buildStatCard("88", "SAVED"),
                ],
              ),
              const SizedBox(height: 32),

              // --- NUTRITION GOALS ---
              _buildSectionHeader("Nutrition Goals", "Details"),
              const SizedBox(height: 12),
              _buildNutritionCard(),

              const SizedBox(height: 32),

              // --- ACCOUNT SETTINGS ---
              _buildSectionHeader("Account Settings", ""),
              const SizedBox(height: 12),
              _buildSettingsItem(Icons.person_outline, "Personal Information", null, const Color(0xFFFF6347).withOpacity(0.1)),
              _buildSettingsItem(Icons.lock_outline, "Post & Privacy Settings", "Configure social publications", const Color(0xFFFF6347).withOpacity(0.1)),

              const SizedBox(height: 24),

              // --- BOTÓN LOGOUT ---
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Color.fromARGB(255, 255, 38, 0)),
                    SizedBox(width: 8),
                    Text("Logout", style: TextStyle(color: Color(0xFFFF6347), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- WIDGETS DE APOYO ---

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 16), 
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20), 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFF6347))),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.blueGrey, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(action, style: const TextStyle(color: Color(0xFFFF6347), fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildNutritionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Daily Calorie Goal", style: TextStyle(color: Colors.grey)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text("1,200", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const Text(" / 2,000 kcal", style: TextStyle(color: Colors.grey)),
              const Spacer(),
              const Text("60%", style: TextStyle(color: Color(0xFFFF6347), fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),  
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.6,
              minHeight: 10,
              backgroundColor: Color(0xFFEEEEEE),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6347)),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Macro Targets", style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMacroItem("Protein", "85g", Colors.redAccent, 85 / 150),
              _buildMacroItem("Carbs", "124g", Colors.orange, 124 / 200),
              _buildMacroItem("Fat", "45g", Colors.amber, 45 / 80),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroItem(String label, String value, Color color, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
            const SizedBox(width: 4),
            Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80, 
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0xFFEEEEEE),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String? subtitle, Color bgColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: bgColor, child: Icon(icon, color: Color(0xFFFF6347))),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)) : null,
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFFFF6347),
      unselectedItemColor: Colors.grey,
      currentIndex: 2,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.feed), label: "FEED"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "SEARCH"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "PROFILE"),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "TRACKER"),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: "MAP"),
      ],
    );
  }
}