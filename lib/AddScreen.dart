import 'package:flutter/material.dart';
import 'package:placement_tracker/HomePage1.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final companyController = TextEditingController();
  final titleController = TextEditingController();
  final cityController = TextEditingController();
  final salaryController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FC),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F8FC),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text(
          "Add Job Entry",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Column(
            children: [
              buildField(
                label: "Company Name",
                hint: "Google, Infosys...",
                icon: Icons.business,
                controller: companyController,
              ),

              buildField(
                label: "Job Title",
                hint: "Software Engineer",
                icon: Icons.work_outline,
                controller: titleController,
              ),

              buildField(
                label: "Location",
                hint: "Mumbai",
                icon: Icons.location_on_outlined,
                controller: cityController,
              ),

              buildField(
                label: "Salary",
                hint: "80000",
                icon: Icons.currency_rupee,
                controller: salaryController,
              ),

              buildField(
                label: "Description",
                hint: "Write job details here...",
                icon: Icons.description_outlined,
                controller: descriptionController,
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 56,

                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF2563EB)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: ElevatedButton(

                    onPressed: () {

                      final newjob = Job(

                        titleController.text,
                        companyController.text,
                        cityController.text,
                        int.parse(salaryController.text),
                        descriptionController.text,
                        
                      );

                      Navigator.pop(context, newjob);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),

                    child: const Text(
                      "Add Entry",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: controller,

            decoration: InputDecoration(
              hintText: hint,

              prefixIcon: Icon(icon, color: Colors.grey.shade600),

              filled: true,
              fillColor: const Color(0xFFF8FAFC),

              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 14,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.blue, width: 1.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
