import 'package:flutter/material.dart';

class Job {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String Description;

  Job({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.Description,
  });
}

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {

  List<Job> jobs = [
    Job(
      title: 'Software Engineer',
      company: 'Google',
      location: 'Mumbai',
      salary: '₹80,000',
      Description: '',
    ),
    Job(
      title: 'Flutter Developer',
      company: 'Infosys',
      location: 'Delhi',
      salary: '₹60,000',
      Description: '',
    ),
  ];

  final List<String> cities = [
    'All',
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Chennai',
  ];

  String? selectedCity;

  void addJob() {
    setState(() {
      jobs.add(
        Job(
          title: 'Backend Developer',
          company: 'TCS',
          location: 'Bangalore',
          salary: '₹70,000',
          Description:''
        ),
      );
    });
  }

  void deleteJob(int index) {
    setState(() {
      jobs.removeAt(index);
    });
  }

  void editJob(int index) {
    
  }

  @override
  Widget build(BuildContext context) {

    final filteredJobs = (selectedCity == null || selectedCity == 'All')
        ? jobs
        : jobs.where((job) => job.location == selectedCity).toList();

    return Scaffold(

      backgroundColor: const Color(0xFFEAF6FB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        centerTitle: true,

        title: const Text(
          'Placement Tracker',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: addJob,
            icon: const Icon(
              Icons.add,
              color: Colors.blueAccent,
              size: 30,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            /// Dropdown
            DropdownButtonFormField<String>(
              initialValue: selectedCity,

              decoration: InputDecoration(
                hintText: 'Select city',

                filled: true,
                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),

              items: cities.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text(city),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
            ),

            const SizedBox(height: 18),

            /// Job List
            Expanded(
              child: ListView.builder(
                
                itemCount: filteredJobs.length,

                itemBuilder: (context, index) {

                  final job = filteredJobs[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),

                    elevation: 4,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(16),

                      child: Row(
                        children: [

                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.blue.shade100,

                            child: const Icon(
                              Icons.work,
                              color: Colors.blue,
                            ),
                          ),

                          const SizedBox(width: 16),

                          /// Job Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [

                                Text(
                                  job.title,

                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  job.company,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),

                                Text(
                                  job.location,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Salary + Actions
                          Column(
                            children: [

                              Text(
                                job.salary,

                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),

                              Row(
                                mainAxisSize: MainAxisSize.min,

                                children: [

                                  IconButton(
                                    onPressed: () => editJob(index),

                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: () => deleteJob(index),

                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}