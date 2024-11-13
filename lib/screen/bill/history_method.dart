import 'package:flutter/material.dart';

class HistoryMethod extends StatefulWidget {
  const HistoryMethod({super.key});

  @override
  _HistoryMethodState createState() => _HistoryMethodState();
}

class _HistoryMethodState extends State<HistoryMethod> {
  final List<Map<String, String>> bills = [
    {'date': '07 August, 2024', 'bill_type': 'Fuel', 'price': 'Rs.12000'},
    {
      'date': '07 August, 2024',
      'bill_type': 'Maintenance Fee',
      'price': 'Rs.12000'
    },
    {'date': '22 October, 2024', 'bill_type': 'Fuel', 'price': 'Rs.15000'},
  ];

  String? selectedBillType = 'Bill Type';
  DateTime? selectedDate;

  List<String> billTypes = ['Bill Type', 'Fuel', 'Maintenance Fee'];

  List<Map<String, String>> get filteredBills {
    return bills.where((bill) {
      final matchesBillType = selectedBillType == null ||
          selectedBillType == 'Bill Type' ||
          bill['bill_type'] == selectedBillType;
      final matchesDate =
          selectedDate == null || bill['date'] == formatDate(selectedDate!);
      return matchesBillType && matchesDate;
    }).toList();
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(1, '0')} ${getMonthName(date.month)}, ${date.year}';
  }

  String getMonthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'March',
      'April',
      'May',
      'June',
      'Jul',
      'Aug',
      'Sept',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedBillType,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  isExpanded: true,
                  items: billTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBillType = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2025),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate == null
                              ? 'Choose Date'
                              : formatDate(selectedDate!),
                          style: const TextStyle(color: Colors.black),
                        ),
                        Visibility(
                          visible: selectedDate != null,
                          // replacement: const SizedBox(width: 48),
                          child: IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              setState(() {
                                selectedDate = null;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredBills.length,
            itemBuilder: (context, index) {
              final item = filteredBills[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_month_outlined,
                                color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              item['date'] ?? '',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff787878)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Bill Type : ${item['bill_type'] ?? ''}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item['price']}',
                          style: const TextStyle(
                              color: Color(0xff787878),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
