import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/patient.dart';

class ProfileHeader extends StatelessWidget {
  final Patient patient;
  final VoidCallback onEditProfile;

  const ProfileHeader({
    super.key,
    required this.patient,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive.getDynamicPadding(context, basePadding: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
        border: Border.all(color: Colors.grey[800]!, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Profile Avatar
              _buildProfileAvatar(context),
              SizedBox(width: Responsive.getSpacing(context, 16)),

              // Profile Info
              Expanded(child: _buildProfileInfo(context)),

              // Edit Button
              _buildEditButton(context),
            ],
          ),

          SizedBox(height: Responsive.getSpacing(context, 16)),

          // Emergency Contact (if available)
          if (patient.emergencyContact != null) _buildEmergencyContact(context),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    return Container(
      width: Responsive.getFontSize(context, 80),
      height: Responsive.getFontSize(context, 80),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            const Color(AppConstants.mintGreen),
            const Color(AppConstants.sereneBlue),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(AppConstants.mintGreen).withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: patient.profileImageUrl != null
          ? ClipOval(
              child: Image.network(
                patient.profileImageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildDefaultAvatar(context);
                },
              ),
            )
          : _buildDefaultAvatar(context),
    );
  }

  Widget _buildDefaultAvatar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(AppConstants.mintGreen),
            Color(AppConstants.sereneBlue),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          _getInitials(patient.name),
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 24),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          patient.name,
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 4)),
        Text(
          patient.email,
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 14),
            color: Colors.grey[400],
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 8)),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.getSpacing(context, 12),
            vertical: Responsive.getSpacing(context, 6),
          ),
          decoration: BoxDecoration(
            color: const Color(AppConstants.mintGreen).withOpacity(0.2),
            borderRadius: BorderRadius.circular(
              Responsive.getBorderRadius(context, 12),
            ),
          ),
          child: Text(
            'Mental Health Journey',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 12),
              fontWeight: FontWeight.w600,
              color: const Color(AppConstants.mintGreen),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return GestureDetector(
      onTap: onEditProfile,
      child: Container(
        padding: EdgeInsets.all(Responsive.getSpacing(context, 8)),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(
            Responsive.getBorderRadius(context, 8),
          ),
          border: Border.all(color: Colors.grey[700]!, width: 1),
        ),
        child: Icon(
          Icons.edit_outlined,
          color: Colors.grey[400],
          size: Responsive.getFontSize(context, 20),
        ),
      ),
    );
  }

  Widget _buildEmergencyContact(BuildContext context) {
    final contact = patient.emergencyContact!;

    return Container(
      padding: Responsive.getDynamicPadding(context, basePadding: 16),
      decoration: BoxDecoration(
        color: Colors.red[900]!.withOpacity(0.2),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 12),
        ),
        border: Border.all(color: Colors.red[400]!.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.emergency,
            color: Colors.red[400],
            size: Responsive.getFontSize(context, 20),
          ),
          SizedBox(width: Responsive.getSpacing(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Emergency Contact',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 14),
                    fontWeight: FontWeight.w600,
                    color: Colors.red[400],
                  ),
                ),
                SizedBox(height: Responsive.getSpacing(context, 2)),
                Text(
                  '${contact.name} (${contact.relationship})',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 12),
                    color: Colors.grey[300],
                  ),
                ),
                Text(
                  contact.phoneNumber,
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 12),
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.phone,
            color: Colors.red[400],
            size: Responsive.getFontSize(context, 18),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.isEmpty) return '?';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words[0][0]}${words[words.length - 1][0]}'.toUpperCase();
  }
}
