import 'package:flutter/material.dart';
import 'package:placement_tracker/HomePage1.dart';

class Editscreen extends StatefulWidget {
  const Editscreen({super.key});

  @override
  State<Editscreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> {
  late TextEditingController titleController;
  late TextEditingController companyController;
  late TextEditingController cityController;
  late TextEditingController salaryController;
  late TextEditingController descriptionController;

  final formKey = GlobalKey<FormState>();
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;
    _initialized = true;

    final job = ModalRoute.of(context)!.settings.arguments as Job;

    titleController = TextEditingController(text: job.title);
    companyController = TextEditingController(text: job.company);
    cityController = TextEditingController(text: job.city);
    salaryController = TextEditingController(text: job.salary.toString());
    descriptionController = TextEditingController(text: job.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    companyController.dispose();
    cityController.dispose();
    salaryController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void saveJob() {
    if (formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        Job(
          titleController.text,
          companyController.text,
          cityController.text,
          int.tryParse(salaryController.text) ?? 0,
          descriptionController.text,
        ),
      );
    }
  }

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
          "Edit Job",
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
          child: Form(
            key: formKey,
            child: Column(
              children: [
                buildField(
                  label: "Job Title",
                  controller: titleController,
                  hint: "Software Engineer",
                  icon: Icons.work_outline,
                ),
                buildField(
                  label: "Company",
                  controller: companyController,
                  hint: "Google",
                  icon: Icons.business,
                ),
                buildField(
                  label: "City",
                  controller: cityController,
                  hint: "Mumbai",
                  icon: Icons.location_on_outlined,
                ),
                buildField(
                  label: "Salary",
                  controller: salaryController,
                  hint: "50000",
                  iconWidget: const Text(
                    '₹',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                buildField(
                  label: "Description",
                  controller: descriptionController,
                  hint: "Job description here",
                  icon: Icons.description_outlined,
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.25),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: saveJob,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Save Changes",
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
      ),
    );
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    required String hint,
    IconData? icon,
  Widget? iconWidget,
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
          TextFormField(
            controller: controller,
            
            validator: (value) => value!.isEmpty ? "Required" : null,
            decoration: InputDecoration(
              
              hintText: hint,
               prefixIcon: iconWidget ??
          (icon != null ? Icon(icon) : null),
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
