import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../cubits/patient_profile_cubit.dart';
import '../widgets/health_metrics_card.dart';
import '../widgets/recent_sessions_card.dart';
import '../widgets/quick_actions_card.dart';
import '../widgets/settings_card.dart';

class PatientProfilePage extends StatefulWidget {
  final String? patientId; // Optional patient ID for viewing specific patient

  const PatientProfilePage({super.key, this.patientId});

  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage>
    with TickerProviderStateMixin {
  late AnimationController _pageAnimationController;
  late Animation<double> _pageFadeAnimation;
  late Animation<Offset> _pageSlideAnimation;
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _pageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _pageFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _pageAnimationController,
        curve: Curves.easeOutQuart,
      ),
    );

    _pageSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _pageAnimationController,
            curve: Curves.easeOutQuart,
          ),
        );

    _pageAnimationController.forward();
  }

  @override
  void dispose() {
    _pageAnimationController.dispose();
    super.dispose();
  }

  bool _isProfileOwner() {
    // If no patientId is provided, it means the current user is viewing their own profile
    // If patientId is provided, it means someone else is viewing this patient's profile
    return widget.patientId == null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientProfileCubit(patientId: widget.patientId),
      child: BlocBuilder<PatientProfileCubit, PatientProfileState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFF121212),
            body: SafeArea(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  // Show title when scrolled past the profile header
                  final shouldShowTitle =
                      scrollInfo.metrics.pixels >
                      Responsive.getFontSize(context, 130);
                  if (shouldShowTitle != _showTitle) {
                    setState(() {
                      _showTitle = shouldShowTitle;
                    });
                  }
                  return false;
                },
                child: FadeTransition(
                  opacity: _pageFadeAnimation,
                  child: SlideTransition(
                    position: _pageSlideAnimation,
                    child: CustomScrollView(
                      slivers: [
                        if (_isProfileOwner()) _buildAppBar(state),
                        _buildContent(state),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(PatientProfileState state) {
    return SliverAppBar(
      expandedHeight: Responsive.getFontSize(context, 130),
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF1A1A1A),
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      title: _showTitle
          ? AnimatedOpacity(
              opacity: _showTitle ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuart,
              child: AnimatedSlide(
                offset: _showTitle ? Offset.zero : const Offset(0, -0.3),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutQuart,
                child: Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 18),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : null,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (state is PatientProfileLoaded) ...[
                Text(
                  'Welcome back,',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 16),
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: Responsive.getSpacing(context, 4)),
                Text(
                  state.patient.name,
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 24),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Responsive.getSpacing(context, 8)),
                Text(
                  'Mental Health Journey',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 14),
                    color: const Color(AppConstants.mintGreen),
                  ),
                ),
              ] else if (state is PatientProfileLoading) ...[
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: Responsive.getFontSize(context, 16),
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(PatientProfileState state) {
    return SliverPadding(
      padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          if (state is PatientProfileLoading)
            _buildLoadingState()
          else if (state is PatientProfileError)
            _buildErrorState(state)
          else if (state is PatientProfileLoaded)
            _buildLoadedContent(state)
          else
            _buildInitialState(),
        ]),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        _buildSkeletonCard(),
        SizedBox(height: Responsive.getSpacing(context, 16)),
        _buildSkeletonCard(),
        SizedBox(height: Responsive.getSpacing(context, 16)),
        _buildSkeletonCard(),
      ],
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      height: Responsive.getFontSize(context, 120),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: const Color(AppConstants.mintGreen),
        ),
      ),
    );
  }

  Widget _buildErrorState(PatientProfileError state) {
    return Container(
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
            Icons.error_outline,
            color: Colors.red[400],
            size: Responsive.getFontSize(context, 48),
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 18),
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 8)),
          Text(
            state.message,
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 14),
              color: Colors.grey[400],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Responsive.getSpacing(context, 16)),
          ElevatedButton(
            onPressed: () {
              context.read<PatientProfileCubit>().refreshProfile();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(AppConstants.mintGreen),
              foregroundColor: Colors.white,
            ),
            child: Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return Container(
      padding: EdgeInsets.all(Responsive.getSpacing(context, 20)),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(
          Responsive.getBorderRadius(context, 16),
        ),
      ),
      child: Center(
        child: Text(
          'Initializing...',
          style: TextStyle(
            fontSize: Responsive.getFontSize(context, 16),
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadedContent(PatientProfileLoaded state) {
    return Column(
      children: [
        // Health Metrics Card
        HealthMetricsCard(healthMetrics: state.healthMetrics),
        SizedBox(height: Responsive.getSpacing(context, 16)),

        // Recent Sessions Card
        RecentSessionsCard(
          sessions: state.recentSessions,
          onViewAll: () =>
              context.read<PatientProfileCubit>().viewAllSessions(),
        ),
        SizedBox(height: Responsive.getSpacing(context, 16)),

        // Quick Actions Card
        QuickActionsCard(
          onScheduleSession: () =>
              context.read<PatientProfileCubit>().scheduleSession(),
          onEmergencyContact: () =>
              context.read<PatientProfileCubit>().openEmergencyContact(),
        ),
        SizedBox(height: Responsive.getSpacing(context, 16)),

        // Settings Card
        SettingsCard(
          onOpenSettings: () =>
              context.read<PatientProfileCubit>().openSettings(),
        ),
      ],
    );
  }
}
