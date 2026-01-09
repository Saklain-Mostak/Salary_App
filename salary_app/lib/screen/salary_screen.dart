import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salary_app/controller/shared_preference_controller.dart';

class SalaryView extends StatelessWidget {
  final controller = Get.put(SalaryController());

  SalaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salary Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Basic Salary'),
              onChanged: (v) {
                controller.basicSalary.value = double.tryParse(v) ?? 0;
                controller.calculate();
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Total Days in Month'),
              onChanged: (v) {
                controller.totalDays.value = int.tryParse(v) ?? 30;
                controller.calculate();
              },
            ),
            const SizedBox(height: 16),
            Obx(
              () => DropdownButton<Attendance>(
                value: controller.attendance.value,
                items: Attendance.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  controller.attendance.value = v!;
                  controller.calculate();
                },
              ),
            ),
            const SizedBox(height: 24),
            Obx(
              () => Text(
                'Total Salary: ${controller.totalSalary.value.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
