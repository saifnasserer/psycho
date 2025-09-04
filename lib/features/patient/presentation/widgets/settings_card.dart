import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';

class SettingsCard extends StatelessWidget {
  final VoidCallback onOpenSettings;

  const SettingsCard({super.key, required this.onOpenSettings});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings & Preferences',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          _buildSettingsList(context),
        ],
      ),
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Column(
      children: [
        _buildSettingsItem(
          context,
          title: 'Account Settings',
          subtitle: 'Manage your account',
          icon: Icons.settings_outlined,
          onTap: onOpenSettings,
        ),
        _buildDivider(context),
        _buildSettingsItem(
          context,
          title: 'Privacy & Security',
          subtitle: 'Control your data and privacy',
          icon: Icons.security_outlined,
          onTap: () {
            // TODO: Navigate to privacy settings
            print('Privacy & Security tapped');
          },
        ),
        _buildDivider(context),
        _buildSettingsItem(
          context,
          title: 'Help & Support',
          subtitle: 'Get help and contact support',
          icon: Icons.help_outline,
          onTap: () {
            // TODO: Navigate to help & support
            print('Help & Support tapped');
          },
        ),
      ],
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        Responsive.getBorderRadius(context, 8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.getSpacing(context, 12),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Responsive.getSpacing(context, 8)),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(context, 8),
                ),
              ),
              child: Icon(
                icon,
                color: Colors.grey[400],
                size: Responsive.getFontSize(context, 20),
              ),
            ),
            SizedBox(width: Responsive.getSpacing(context, 16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 16),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Responsive.getSpacing(context, 2)),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: Responsive.getFontSize(context, 14),
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[600],
              size: Responsive.getFontSize(context, 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(
        horizontal: Responsive.getSpacing(context, 16),
      ),
      color: Colors.grey[800],
    );
  }
}
