import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/constants/app_constants.dart';
import '../cubits/specialist_home_cubit.dart';
import '../tabs/calender_tab.dart';
import '../tabs/clients_tab.dart';
import '../tabs/ai_tab.dart';
import '../widgets/add_session_bottom_sheet.dart';

class SpecialistHomePage extends StatefulWidget {
  const SpecialistHomePage({super.key});

  @override
  State<SpecialistHomePage> createState() => _SpecialistHomePageState();
}

class _SpecialistHomePageState extends State<SpecialistHomePage>
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

  void _showAddSessionBottomSheet(
    BuildContext context,
    SpecialistHomeState state,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddSessionBottomSheet(state: state),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpecialistHomeCubit(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<SpecialistHomeCubit, SpecialistHomeState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: const Color(0xFF121212),
                body: SafeArea(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      // Show title when scrolled past the welcome section
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
                          slivers: [_buildContent(state)],
                        ),
                      ),
                    ),
                  ),
                ),
                floatingActionButton: state.selectedTabIndex == 0
                    ? FloatingActionButton(
                        onPressed: () =>
                            _showAddSessionBottomSheet(context, state),
                        backgroundColor: const Color(AppConstants.mintGreen),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: Responsive.getFontSize(context, 24),
                        ),
                      )
                    : null,
                bottomNavigationBar: _buildBottomNavigation(state, context),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildContent(SpecialistHomeState state) {
    // AI tab needs full screen without padding
    if (state.selectedTabIndex == 2) {
      return SliverFillRemaining(child: _buildTabContent(state));
    }

    // Other tabs use normal padding
    return SliverPadding(
      padding: EdgeInsets.all(Responsive.getSpacing(context, 25)),
      sliver: SliverList(
        delegate: SliverChildListDelegate([_buildTabContent(state)]),
      ),
    );
  }

  Widget _buildTabContent(SpecialistHomeState state) {
    switch (state.selectedTabIndex) {
      case 0: // Home tab
        return HomeTab(state: state);
      case 1: // Clients tab
        return ClientsTab(state: state);
      case 2: // AI tab
        return AITab(state: state);
      default:
        return HomeTab(state: state);
    }
  }

  Widget _buildBottomNavigation(
    SpecialistHomeState state,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border(top: BorderSide(color: Colors.grey[800]!, width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: state.selectedTabIndex,
        onTap: (index) {
          context.read<SpecialistHomeCubit>().setTabIndex(index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: const Color(AppConstants.mintGreen),
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: TextStyle(
          fontSize: Responsive.getFontSize(context, 12),
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: Responsive.getFontSize(context, 12),
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day_rounded),
            label: 'Calender',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Clients'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
