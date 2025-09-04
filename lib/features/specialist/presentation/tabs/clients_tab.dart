import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../cubits/specialist_home_cubit.dart';
import '../widgets/client_card.dart';
import '../../../patient/presentation/pages/patient_profile_page.dart';

class ClientsTab extends StatelessWidget {
  final SpecialistHomeState state;

  const ClientsTab({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Clients',
              style: TextStyle(
                fontSize: Responsive.getFontSize(context, 18),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        SizedBox(height: Responsive.getSpacing(context, 16)),
        if (state.recentClients.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 16),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.people_outline,
                  color: Colors.grey[600],
                  size: Responsive.getFontSize(context, 48),
                ),
                SizedBox(height: Responsive.getSpacing(context, 12)),
                Text(
                  'No clients yet',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 16),
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: Responsive.getSpacing(context, 8)),
                Text(
                  'Your clients will appear here',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 14),
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          )
        else
          ...state.recentClients.map(
            (client) => Padding(
              padding: EdgeInsets.only(
                bottom: Responsive.getSpacing(context, 12),
              ),
              child: ClientCardNew(
                client: client,
                onTap: () {
                  // Navigate to patient profile
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PatientProfilePage(patientId: client.id),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
