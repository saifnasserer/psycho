import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../cubits/specialist_home_cubit.dart';

class AddSessionBottomSheet extends StatefulWidget {
  final SpecialistHomeState state;

  const AddSessionBottomSheet({super.key, required this.state});

  @override
  State<AddSessionBottomSheet> createState() => _AddSessionBottomSheetState();
}

class _AddSessionBottomSheetState extends State<AddSessionBottomSheet> {
  bool _isNewSession = true;
  String? _selectedClientId;
  String _sessionStartTime = '09:00';
  String _sessionEndTime = '10:00';
  String _recurrenceType = 'none';
  String _notes = '';
  List<String> _selectedGoals = [];
  String _newClientName = '';
  String _newClientLastName = '';
  String _greetingText = '';

  final List<String> _availableGoals = [
    'Relaxation',
    'Contact with Anger',
    'Anxiety Management',
    'Depression Support',
    'Trauma Processing',
    'Relationship Issues',
    'Self-Esteem',
    'Stress Management',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Responsive.getBorderRadius(context, 20)),
          topRight: Radius.circular(Responsive.getBorderRadius(context, 20)),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: Responsive.getFontSize(context, 40),
            height: Responsive.getFontSize(context, 4),
            margin: EdgeInsets.only(top: Responsive.getSpacing(context, 12)),
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add New Session',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 20),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[400],
                    size: Responsive.getFontSize(context, 24),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.getSpacing(context, 20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Session Type Radio Buttons
                  _buildSessionTypeSelector(),
                  SizedBox(height: Responsive.getSpacing(context, 24)),

                  // Form Content based on selection
                  if (_isNewSession)
                    _buildNewClientForm()
                  else
                    _buildSavedClientForm(),

                  SizedBox(height: Responsive.getSpacing(context, 32)),

                  // Action Buttons
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Session Type',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 16),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 12)),
        Row(
          children: [
            Expanded(
              child: _buildRadioOption('New Session', true, Icons.person_add),
            ),
            SizedBox(width: Responsive.getSpacing(context, 16)),
            Expanded(
              child: _buildRadioOption('Saved Session', false, Icons.person),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioOption(String title, bool value, IconData icon) {
    return GestureDetector(
      onTap: () => setState(() => _isNewSession = value),
      child: Container(
        padding: EdgeInsets.all(Responsive.getSpacing(context, 16)),
        decoration: BoxDecoration(
          color: _isNewSession == value
              ? const Color(AppConstants.mintGreen).withValues(alpha: 0.1)
              : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(
            Responsive.getBorderRadius(context, 12),
          ),
          border: Border.all(
            color: _isNewSession == value
                ? const Color(AppConstants.mintGreen)
                : Colors.grey[700]!,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: _isNewSession == value
                  ? const Color(AppConstants.mintGreen)
                  : Colors.grey[400],
              size: Responsive.getFontSize(context, 24),
            ),
            SizedBox(height: Responsive.getSpacing(context, 8)),
            Text(
              title,
              style: TextStyle(
                fontSize: Responsive.getFontSize(context, 14),
                fontWeight: FontWeight.w600,
                color: _isNewSession == value ? Colors.white : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewClientForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name and Last Name
        _buildTextField(
          'Name',
          _newClientName,
          (value) => _newClientName = value,
        ),
        SizedBox(height: Responsive.getSpacing(context, 16)),
        _buildTextField(
          'Last Name',
          _newClientLastName,
          (value) => _newClientLastName = value,
        ),
        SizedBox(height: Responsive.getSpacing(context, 24)),

        // Recurrence
        _buildRecurrenceSelector(),
        SizedBox(height: Responsive.getSpacing(context, 24)),

        // Goals
        _buildGoalsSelector(),
        SizedBox(height: Responsive.getSpacing(context, 24)),

        // Notes
        _buildNotesField(),
        SizedBox(height: Responsive.getSpacing(context, 24)),

        // Greeting Text
        _buildGreetingTextSection(),
      ],
    );
  }

  Widget _buildSavedClientForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Client Dropdown
        _buildClientDropdown(),
        SizedBox(height: Responsive.getSpacing(context, 24)),

        // Session Time
        _buildSessionTimeSelector(),
        SizedBox(height: Responsive.getSpacing(context, 24)),

        // Recurrence
        _buildRecurrenceSelector(),
        SizedBox(height: Responsive.getSpacing(context, 24)),

        // Notes
        _buildNotesField(),
        SizedBox(height: Responsive.getSpacing(context, 24)),

        // Goals
        _buildGoalsSelector(),
        SizedBox(height: Responsive.getSpacing(context, 24)),

        // AI Report
        _buildAIReportSection(),
      ],
    );
  }

  Widget _buildClientDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Client',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 16),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 8)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.getSpacing(context, 16),
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(
              Responsive.getBorderRadius(context, 12),
            ),
            border: Border.all(color: Colors.grey[700]!, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedClientId,
              hint: Text(
                'Choose a client...',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: Responsive.getFontSize(context, 14),
                ),
              ),
              isExpanded: true,
              dropdownColor: const Color(0xFF2A2A2A),
              style: TextStyle(
                color: Colors.white,
                fontSize: Responsive.getFontSize(context, 14),
              ),
              items: widget.state.recentClients.map((client) {
                return DropdownMenuItem<String>(
                  value: client.id,
                  child: Text(client.name),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedClientId = value),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String value,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 16),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 8)),
        TextField(
          onChanged: onChanged,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter $label',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: const Color(0xFF2A2A2A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 12),
              ),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 12),
              ),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 12),
              ),
              borderSide: BorderSide(
                color: const Color(AppConstants.mintGreen),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSessionTimeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Session Time',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 16),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 12)),
        Row(
          children: [
            Expanded(
              child: _buildTimeField(
                'Start Time',
                _sessionStartTime,
                (value) => _sessionStartTime = value,
              ),
            ),
            SizedBox(width: Responsive.getSpacing(context, 16)),
            Expanded(
              child: _buildTimeField(
                'End Time',
                _sessionEndTime,
                (value) => _sessionEndTime = value,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeField(
    String label,
    String value,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 14),
            color: Colors.grey[400],
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 4)),
        TextField(
          onChanged: onChanged,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: '00:00',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: const Color(0xFF2A2A2A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 12),
              ),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 12),
              ),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 12),
              ),
              borderSide: BorderSide(
                color: const Color(AppConstants.mintGreen),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecurrenceSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recurrence',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 16),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 12)),
        Wrap(
          spacing: Responsive.getSpacing(context, 8),
          runSpacing: Responsive.getSpacing(context, 8),
          children: ['none', 'day', 'week', 'month'].map((type) {
            return GestureDetector(
              onTap: () => setState(() => _recurrenceType = type),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.getSpacing(context, 16),
                  vertical: Responsive.getSpacing(context, 8),
                ),
                decoration: BoxDecoration(
                  color: _recurrenceType == type
                      ? const Color(AppConstants.mintGreen)
                      : const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(
                    Responsive.getBorderRadius(context, 20),
                  ),
                  border: Border.all(
                    color: _recurrenceType == type
                        ? const Color(AppConstants.mintGreen)
                        : Colors.grey[700]!,
                  ),
                ),
                child: Text(
                  type == 'none' ? 'None' : type.toUpperCase(),
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 12),
                    fontWeight: FontWeight.w600,
                    color: _recurrenceType == type
                        ? Colors.white
                        : Colors.grey[400],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGoalsSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Goals for Session',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 16),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 12)),
        Wrap(
          spacing: Responsive.getSpacing(context, 8),
          runSpacing: Responsive.getSpacing(context, 8),
          children: _availableGoals.map((goal) {
            final isSelected = _selectedGoals.contains(goal);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedGoals.remove(goal);
                  } else {
                    _selectedGoals.add(goal);
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.getSpacing(context, 12),
                  vertical: Responsive.getSpacing(context, 6),
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(
                          AppConstants.mintGreen,
                        ).withValues(alpha: 0.2)
                      : const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(
                    Responsive.getBorderRadius(context, 16),
                  ),
                  border: Border.all(
                    color: isSelected
                        ? const Color(AppConstants.mintGreen)
                        : Colors.grey[700]!,
                  ),
                ),
                child: Text(
                  goal,
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 12),
                    color: isSelected
                        ? const Color(AppConstants.mintGreen)
                        : Colors.grey[400],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Notes',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 16),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 8)),
        TextField(
          onChanged: (value) => _notes = value,
          maxLines: 4,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Add your notes here...',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: const Color(0xFF2A2A2A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 12),
              ),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 12),
              ),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 12),
              ),
              borderSide: BorderSide(
                color: const Color(AppConstants.mintGreen),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreetingTextSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Greeting Text for AI Assistant',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 16),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 8)),
        TextField(
          onChanged: (value) => _greetingText = value,
          maxLines: 3,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter greeting text for the new client...',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: const Color(0xFF2A2A2A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 12),
              ),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 12),
              ),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Responsive.getBorderRadius(context, 12),
              ),
              borderSide: BorderSide(
                color: const Color(AppConstants.mintGreen),
              ),
            ),
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 12)),
        Container(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Generate link for new client
              print('Generate link for new client');
            },
            icon: Icon(Icons.link, color: Colors.white),
            label: Text('Generate Link for New Client'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(AppConstants.mintGreen),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: Responsive.getSpacing(context, 12),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(context, 12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAIReportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Automatic Recent AI Report',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 16),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: Responsive.getSpacing(context, 8)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Responsive.getSpacing(context, 16)),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(
              Responsive.getBorderRadius(context, 12),
            ),
            border: Border.all(color: Colors.grey[700]!),
          ),
          child: Column(
            children: [
              Icon(
                Icons.psychology,
                color: const Color(AppConstants.mintGreen),
                size: Responsive.getFontSize(context, 32),
              ),
              SizedBox(height: Responsive.getSpacing(context, 8)),
              Text(
                'AI Report Available',
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 14),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: Responsive.getSpacing(context, 4)),
              Text(
                'Recent AI analysis will be automatically included',
                style: TextStyle(
                  fontSize: Responsive.getFontSize(context, 12),
                  color: Colors.grey[400],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[600]!),
              foregroundColor: Colors.grey[400],
              padding: EdgeInsets.symmetric(
                vertical: Responsive.getSpacing(context, 16),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(context, 12),
                ),
              ),
            ),
            child: Text('Cancel'),
          ),
        ),
        SizedBox(width: Responsive.getSpacing(context, 16)),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // TODO: Save session
              print('Save session');
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(AppConstants.mintGreen),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: Responsive.getSpacing(context, 16),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(context, 12),
                ),
              ),
            ),
            child: Text('Save Session'),
          ),
        ),
      ],
    );
  }
}
