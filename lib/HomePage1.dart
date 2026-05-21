import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Job {
  String title;
  String company;
  String city;
  String description;
  int salary;

  Job(
    this.title,
    this.company,
    this.city,
    this.salary,
    this.description,
  );

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "company": company,
      "city": city,
      "salary": salary,
      "description": description,
    };
  }

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      json['title'] ?? '',
      json['company'] ?? '',
      json['city'] ?? '',
      json['salary'] is int
          ? json['salary']
          : int.tryParse(json['salary'].toString()) ?? 0,
      json['description'] ?? '',
    );
  }
}

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  List<Job> jobs = [];

  final List<String> cities = [
    'All',
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Chennai',
  ];

  String? selectedCity;

  @override
  void initState() {
    super.initState();
    getlist();
  }

  Future<void> addJob() async {
    final result = await Navigator.pushNamed(context, '/AddScreen');

    if (result != null && result is Job) {
      setState(() {
        jobs.add(result);
      });

      await savelist();
    }
  }

  void deleteJob(Job job) async {
    setState(() {
      jobs.remove(job);
    });

    await savelist();
  }

  Future<void> editJob(Job job) async {
    final updatedJob = await Navigator.pushNamed(
      context,
      '/EditScreen',
      arguments: job,
    );

    if (updatedJob != null && updatedJob is Job) {
      setState(() {
        final index = jobs.indexOf(job);

        if (index != -1) {
          jobs[index] = updatedJob;
        }
      });

      await savelist();
    }
  }

  Future<void> savelist() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    String jsonString =
        jsonEncode(jobs.map((e) => e.toJson()).toList());

    await prefs.setString("MyList", jsonString);
  }

  Future<void> getlist() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    String? jsonString = prefs.getString("MyList");

    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> jsonList = jsonDecode(jsonString);

      setState(() {
        jobs = jsonList
            .map((e) => Job.fromJson(e))
            .toList();
      });
    } else {
      setState(() {
        jobs = [
          Job(
            'Software Engineer',
            'Google',
            'Mumbai',
            80000,
            'Responsible for developing and maintaining software applications.',
          ),
          Job(
            'Flutter Developer',
            'Infosys',
            'Delhi',
            70000,
            'Develops mobile applications using Flutter framework.',
          ),
          Job(
            'Backend Developer',
            'TCS',
            'Bangalore',
            90000,
            'Designs and implements backend systems and APIs.',
          ),
        ];
      });

      await savelist();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredJobs =
        (selectedCity == null || selectedCity == 'All')
        ? jobs
        : jobs
              .where((job) => job.city == selectedCity)
              .toList();

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
            DropdownButtonFormField<String>(
              value: selectedCity,

              decoration: InputDecoration(
                hintText: 'Select city',
                filled: true,
                fillColor: Colors.white,

                contentPadding:
                    const EdgeInsets.symmetric(
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

            Expanded(
              child: filteredJobs.isEmpty
                  ? const Center(
                      child: Text(
                        "No Jobs Found",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredJobs.length,

                      itemBuilder: (context, index) {
                        final job = filteredJobs[index];

                        return Card(
                          margin: const EdgeInsets.only(
                            bottom: 16,
                          ),

                          elevation: 4,

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(18),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(16),

                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor:
                                      Colors.blue.shade100,

                                  child: const Icon(
                                    Icons.work,
                                    color: Colors.blue,
                                  ),
                                ),

                                const SizedBox(width: 16),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        job.company,

                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Text(
                                        job.title,

                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ),

                                      Text(
                                        job.city,

                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Text(
                                        job.description,

                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      Text(
                                        'Salary: ₹${job.salary}',

                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Row(
                                  mainAxisSize:
                                      MainAxisSize.min,

                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          editJob(job),

                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () =>
                                          deleteJob(job),

                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
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