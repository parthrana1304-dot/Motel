import 'package:flutter/material.dart';
import 'monthly_follow_page.dart';
import 'weekly_follow_page.dart';
import './profile_page.dart';

class FollowUpHomePage extends StatelessWidget {
  final String motelName;

  const FollowUpHomePage({super.key, required this.motelName});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          motelName,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // 👤 profile icon
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black54),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(motelName: motelName),
                ),
              );
            },
          ),

          // ⋮ 3-dot menu
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black54),
            onSelected: (value) {
              if (value == "website") {
                // later you can open url_launcher here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("https://www.snydermotels.com/"),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "website",
                child: Row(
                  children: [
                    Icon(Icons.public, size: 18),
                    SizedBox(width: 10),
                    Text("snydermotels.com"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      // ================= BODY =================
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Text(
                  "Daily Follow Up",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 30),

                // ================= ACTION CARDS =================
                isMobile
                    ? Column(
                        children: [
                          _followCard(
                            context,
                            title: "Weekly Daily Follow Up",
                            subtitle: "Rooms • Revenue • Operations",
                            icon: Icons.calendar_view_week,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      WeeklyFollowUpPage(motelName: motelName),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          _followCard(
                            context,
                            title: "Monthly Daily Follow Up",
                            subtitle: "Performance • Costs • Reviews",
                            icon: Icons.calendar_month,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MonthlyFollowUpPage(motelName: motelName),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _followCard(
                            context,
                            title: "Weekly Daily Follow Up",
                            subtitle: "Rooms • Revenue • Operations",
                            icon: Icons.calendar_view_week,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      WeeklyFollowUpPage(motelName: motelName),
                                ),
                              );
                            },
                          ),
                          _followCard(
                            context,
                            title: "Monthly Daily Follow Up",
                            subtitle: "Performance • Costs • Reviews",
                            icon: Icons.calendar_month,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MonthlyFollowUpPage(motelName: motelName),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= CARD =================
  static Widget _followCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 400,
      height: 170,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 38, color: const Color(0xFF1E3A8A)),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}
