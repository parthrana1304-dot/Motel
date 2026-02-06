import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './profile_page.dart';

class MonthlyFollowUpPage extends StatefulWidget {
  final String motelName;

  const MonthlyFollowUpPage({super.key, required this.motelName});

  @override
  State<MonthlyFollowUpPage> createState() => _MonthlyFollowUpPageState();
}

class _MonthlyFollowUpPageState extends State<MonthlyFollowUpPage> {
  
  DateTime selectedDate = DateTime.now();

  final Map<String, TextEditingController> controllers = {
    // Room Performance
    "Total Rooms": TextEditingController(),
    "Available Rooms": TextEditingController(),
    "Average Daily Rooms Sold": TextEditingController(),
    "Weekly Rooms Sold": TextEditingController(),
    "Total Rooms Sold (Month)": TextEditingController(),
    "Upcoming Reservations": TextEditingController(),
    "Auto Occupancy %": TextEditingController(),
    "Auto ADR": TextEditingController(),
    "Auto Monthly Revenue": TextEditingController(),
    "Cash Amount": TextEditingController(),
    "Card Amount": TextEditingController(),
    "Labor Hours": TextEditingController(),
    "Labor Cost": TextEditingController(),
    "Inventory Notes": TextEditingController(),
    "Maintenance Notes": TextEditingController(),

    // Financial Controls
    "Labor %": TextEditingController(),
    "Utilities %": TextEditingController(),
    "Maintenance %": TextEditingController(),
    "OTA %": TextEditingController(),
    "Management %": TextEditingController(),
    "Tax %": TextEditingController(),
    "Insurance %": TextEditingController(),
    "CPA Fee": TextEditingController(),
    "Legal Fee": TextEditingController(),
    "Misc Expense %": TextEditingController(),
    "Debt %": TextEditingController(),
    "Auto Profit %": TextEditingController(),

    // Strategy & Follow-up
    "ADR Strategy Notes": TextEditingController(),
    "Profitability Notes": TextEditingController(),
    "System Fix Notes": TextEditingController(),
    "Staff Notes": TextEditingController(),
    "Leakage Notes": TextEditingController(),
    "Marketing Actions": TextEditingController(),
    "KPI Notes": TextEditingController(),
    "OTA Notes": TextEditingController(),
    "Comp Room Details": TextEditingController(),
    "Manager Notes": TextEditingController(),
    "CPA Discussion Notes": TextEditingController(),
    "Vendor Notes": TextEditingController(),
    "Audit Notes": TextEditingController(),
    "Sales Strategy": TextEditingController(),
    "Guest Review": TextEditingController(),
    "Expense Control Notes": TextEditingController(),
    "Bonus Criteria": TextEditingController(),
  };

  /// Auto calculations
  void _autoCalculate() {
    final totalRooms =
        double.tryParse(controllers["Total Rooms"]?.text ?? "0") ?? 0;
    final roomsSold =
        double.tryParse(controllers["Total Rooms Sold (Month)"]?.text ?? "0") ??
        0;
    final revenue =
        double.tryParse(controllers["Auto Monthly Revenue"]?.text ?? "0") ?? 0;
    final expense =
        double.tryParse(controllers["Misc Expense %"]?.text ?? "0") ?? 0;

    if (totalRooms > 0 && roomsSold > 0) {
      controllers["Auto Occupancy %"]?.text =
          "${((roomsSold / totalRooms) * 100).toStringAsFixed(2)} %";
    }

    if (roomsSold > 0 && revenue > 0) {
      controllers["Auto ADR"]?.text = (revenue / roomsSold).toStringAsFixed(2);
    }

    if (revenue > 0) {
      controllers["Auto Profit %"]?.text = ((revenue - expense) / revenue * 100)
          .toStringAsFixed(2);
    }
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
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                    DateFormat("MMMM yyyy").format(selectedDate),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: [
                  // ROOM PERFORMANCE
                  _newSection("Room Performance", [
                    _numberField("Total Rooms", onChange: _autoCalculate),
                    _numberField("Available Rooms"),
                    _numberField("Average Daily Rooms Sold"),
                    _numberField("Weekly Rooms Sold"),
                    _numberField(
                      "Total Rooms Sold (Month)",
                      onChange: _autoCalculate,
                    ),
                    _numberField("Upcoming Reservations"),
                    _numberField("Auto Occupancy %", readOnly: true),
                    _numberField("Auto ADR", readOnly: true),
                    _numberField(
                      "Auto Monthly Revenue",
                      onChange: _autoCalculate,
                    ),
                    _numberField("Cash Amount"),
                    _numberField("Card Amount"),
                    _numberField("Labor Hours"),
                    _numberField("Labor Cost"),
                    _textField("Inventory Notes", maxLines: 2),
                    _textField("Maintenance Notes", maxLines: 2),
                  ]),

                  // FINANCIAL CONTROLS
                  _newSection("Financial Controls", [
                    _numberField("Labor %"),
                    _numberField("Utilities %"),
                    _numberField("Maintenance %"),
                    _numberField("OTA %"),
                    _numberField("Management %"),
                    _numberField("Tax %"),
                    _numberField("Insurance %"),
                    _numberField("CPA Fee"),
                    _numberField("Legal Fee"),
                    _numberField("Misc Expense %"),
                    _numberField("Debt %"),
                    _numberField("Auto Profit %", readOnly: true),
                  ]),

                  // STRATEGY & FOLLOW-UP
                  _newSection("Strategy & Follow-up", [
                    _textField("ADR Strategy Notes", maxLines: 2),
                    _textField("Profitability Notes", maxLines: 2),
                    _textField("System Fix Notes", maxLines: 2),
                    _textField("Staff Notes", maxLines: 2),
                    _textField("Leakage Notes", maxLines: 2),
                    _textField("Marketing Actions", maxLines: 2),
                    _textField("KPI Notes", maxLines: 2),
                    _textField("OTA Notes", maxLines: 2),
                    _textField("Comp Room Details", maxLines: 2),
                    _textField("Manager Notes", maxLines: 2),
                    _textField("CPA Discussion Notes", maxLines: 2),
                    _textField("Vendor Notes", maxLines: 2),
                    _textField("Audit Notes", maxLines: 2),
                    _textField("Sales Strategy", maxLines: 2),
                    _textField("Guest Review", maxLines: 2),
                    _textField("Expense Control Notes", maxLines: 2),
                    _textField("Bonus Criteria", maxLines: 2),
                  ]),

                  const SizedBox(height: 80), // Extra space for floating save
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Monthly follow-up saved")),
          );
        },
        label: const Text("Save"),
        icon: const Icon(Icons.save),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  /// ================== WIDGET HELPERS ==================
  Widget _newSection(String title, List<Widget> children) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
            Wrap(spacing: 16, runSpacing: 12, children: children),
          ],
        ),
      ),
    );
  }

  Widget _numberField(
    String key, {
    bool readOnly = false,
    VoidCallback? onChange,
  }) {
    return SizedBox(
      width: 180,
      child: TextField(
        controller: controllers[key],
        readOnly: readOnly,
        keyboardType: TextInputType.number,
        onChanged: (_) => onChange?.call(),
        decoration: _fieldDecoration(key),
      ),
    );
  }

  Widget _textField(String key, {int maxLines = 1}) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: controllers[key],
        maxLines: maxLines,
        decoration: _fieldDecoration(key),
      ),
    );
  }

  InputDecoration _fieldDecoration(String label) {
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
