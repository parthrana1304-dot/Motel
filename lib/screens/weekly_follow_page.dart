import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './profile_page.dart';
class WeeklyFollowUpPage extends StatefulWidget {
  final String motelName;

  const WeeklyFollowUpPage({super.key, required this.motelName});

  @override
  State<WeeklyFollowUpPage> createState() => _WeeklyFollowUpPageState();
}

class _WeeklyFollowUpPageState extends State<WeeklyFollowUpPage> {
  DateTime selectedDate = DateTime.now();

  final Map<String, TextEditingController> controllers = {
    "Rooms Available": TextEditingController(),
    "Daily Rooms Sold": TextEditingController(),
    "Weekly Rooms Sold": TextEditingController(),
    "Total Rooms Sold": TextEditingController(),
    "Coming Reservation Today": TextEditingController(),
    "Occupancy %": TextEditingController(),
    "ADR": TextEditingController(),
    "Total Room Revenue": TextEditingController(),
    "Future Reservation Made Today": TextEditingController(),
    "Cash & Card Deposit": TextEditingController(),
    "HK 1 Labor Cost": TextEditingController(),
    "HK 2 Labor Cost": TextEditingController(),
    "Expedia Price Comp Set": TextEditingController(),
    "Booking.com Price Comp Set": TextEditingController(),
    "No Shows / Complaints / Refund": TextEditingController(),
    "Maintenance Issues": TextEditingController(),
    "Maintenance List & Cost": TextEditingController(),
    "Labor On Duty Hrs & Cost": TextEditingController(),
    "Daily Rooms Inspection": TextEditingController(),
    "Weekly Preventive Checklist": TextEditingController(),
    "Weekly Mail Check & Action": TextEditingController(),
    "Weekly P&L Review": TextEditingController(),
    "Local Business Contracts": TextEditingController(),
    "Respond Reviews & Emails": TextEditingController(),
    "OTA Smart Use": TextEditingController(),
    "Customer Check-in/out Call": TextEditingController(),
    "Expense Cash": TextEditingController(),
    "Expense Credit Card": TextEditingController(),
    "Expense Check": TextEditingController(),
    "Mail Received Today": TextEditingController(),
    "Manager Note": TextEditingController(),
  };

  void _autoCalculateRooms() {
    final daily = int.tryParse(controllers["Daily Rooms Sold"]!.text) ?? 0;
    final weekly = int.tryParse(controllers["Weekly Rooms Sold"]!.text) ?? 0;
    controllers["Total Rooms Sold"]!.text = (daily + weekly).toString();
  }

  @override
  void dispose() {
    for (final c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          widget.motelName,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black54),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(motelName: widget.motelName),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              icon: const Icon(Icons.save, color: Colors.blueAccent),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Monthly follow-up saved")),
                );
              },
            ),
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // DATE PICKER
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.blueAccent),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) setState(() => selectedDate = picked);
                  },
                  child: Text(
                    DateFormat("dd MMM yyyy").format(selectedDate),
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: [
                  _section("Rooms & Revenue", [
                    _number("Rooms Available"),
                    _number("Daily Rooms Sold", onChange: _autoCalculateRooms),
                    _number("Weekly Rooms Sold", onChange: _autoCalculateRooms),
                    _number("Total Rooms Sold", readOnly: true),
                    _number("Coming Reservation Today"),
                    _number("Occupancy %"),
                    _number("ADR"),
                    _number("Total Room Revenue"),
                    _number("Future Reservation Made Today"),
                  ]),

                  _section("Deposits & Labor", [
                    _number("Cash & Card Deposit"),
                    _number("HK 1 Labor Cost"),
                    _number("HK 2 Labor Cost"),
                  ]),

                  _section("OTA & Issues", [
                    _text("Expedia Price Comp Set"),
                    _text("Booking.com Price Comp Set"),
                    _text("No Shows / Complaints / Refund"),
                  ]),

                  _section("Operations", [
                    _text("Maintenance Issues"),
                    _text("Maintenance List & Cost"),
                    _text("Labor On Duty Hrs & Cost"),
                    _text("Daily Rooms Inspection"),
                    _text("Weekly Preventive Checklist"),
                    _text("Weekly Mail Check & Action"),
                    _text("Weekly P&L Review"),
                    _text("Local Business Contracts"),
                    _text("Respond Reviews & Emails"),
                    _text("OTA Smart Use"),
                    _text("Customer Check-in/out Call"),
                  ]),

                  _section("Expense", [
                    _number("Expense Cash"),
                    _number("Expense Credit Card"),
                    _number("Expense Check"),
                    _text("Mail Received Today"),
                  ]),

                  _section("Manager Note", [
                    _text("Manager Note", maxLines: 3),
                  ]),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        icon: const Icon(Icons.save),
        label: const Text("Save"),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Weekly follow-up saved")),
          );
        },
      ),
    );
  }

  /// ================= UI HELPERS =================
  Widget _section(String title, List<Widget> fields) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: fields,
            ),
          ],
        ),
      ),
    );
  }

  Widget _number(String key,
      {bool readOnly = false, VoidCallback? onChange}) {
    return SizedBox(
      width: 180,
      child: TextField(
        controller: controllers[key],
        readOnly: readOnly,
        keyboardType: TextInputType.number,
        onChanged: (_) => onChange?.call(),
        decoration: _decoration(key),
      ),
    );
  }

  Widget _text(String key, {int maxLines = 1}) {
    return SizedBox(
      width: 360,
      child: TextField(
        controller: controllers[key],
        maxLines: maxLines,
        decoration: _decoration(key),
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color(0xFFF1F3F6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
