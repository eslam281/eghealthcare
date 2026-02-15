import 'package:flutter/material.dart';

import '../widgets/doctor_card.dart';

class FindDoctorsPage extends StatelessWidget {
  const FindDoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              /// Title
              Row(
                children: [
                  BackButton(
                    color: colors.onSurfaceVariant,
                    onPressed: () {Navigator.pop(context);},
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Find a Doctor",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 8),
        
              Text(
                "Browse our network of qualified healthcare professionals",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
        
              const SizedBox(height: 24),
        
              /// Search + Filter Row
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search by name or specialty...",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: colors.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
        
                  const SizedBox(width: 16),
        
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: "All",
                        items: const [
                          DropdownMenuItem(
                            value: "All",
                            child: Text("All Specialties"),
                          ),
                          DropdownMenuItem(
                            value: "All2",
                            child: Text("sad"),
                          ),
                          DropdownMenuItem(
                            value: "All3",
                            child: Text("sf sfas"),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  )
                ],
              ),
        
              const SizedBox(height: 24),
        
              /// Doctors Grid
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 16, bottom: 24),
                  itemCount: 6,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) => const DoctorCard(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
