import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../controllers/covid_controller.dart';
import '../widgets/stats_card.dart';
import '../widgets/line_chart_widget.dart';
import '../widgets/donut_chart_widget.dart';

/// The main screen of the app — shows COVID-19 stats, charts, and a refresh button.
///
/// This view doesn't hold any logic itself; it simply observes the [CovidController]
/// and rebuilds whenever the controller's state changes. That keeps the view thin
/// and makes the logic easy to test in isolation.
class DashboardView extends GetView<CovidController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Transparent so the gradient container behind the appbar shows through
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.darkBlue, AppTheme.primaryBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // Logo + title — constrained so the appbar height stays standard
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/logos/ehealth_logo.png',
                height: 28,
                width: 28,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            const Text('COVID-19 Tracker'),
          ],
        ),
        actions: [
          // Show a small spinner while loading, or a refresh icon when idle/done
          Obx(() => controller.state.value == DashboardState.loading
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.refresh_rounded),
                  tooltip: 'Refresh',
                  onPressed: controller.fetchData,
                )),
        ],
      ),
      // Obx rebuilds the body whenever the controller's observables change
      body: Obx(() => _buildBody(context)),
    );
  }

  /// Routes to the correct sub-view based on the current dashboard state.
  Widget _buildBody(BuildContext context) {
    switch (controller.state.value) {
      case DashboardState.loading:
        return const _LoadingView();
      case DashboardState.error:
        return _ErrorView(
          message: controller.errorMessage.value,
          onRetry: controller.fetchData,
        );
      case DashboardState.success:
        if (controller.globalStats.value != null) {
          return _SuccessView(controller: controller);
        }
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}

// ─────────────────────────────────────────────
// Loading state — centered spinner with a hint
// ─────────────────────────────────────────────
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppTheme.primaryBlue,
              backgroundColor: AppTheme.primaryBlue.withOpacity(0.12),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Fetching latest data...',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Error state — friendly message with a retry button
// ─────────────────────────────────────────────
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEF5350).withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.wifi_off_rounded,
                  size: 48, color: Color(0xFFEF5350)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Failed to load data',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: 180,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 20),
                label: const Text('Try Again',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shadowColor: AppTheme.primaryBlue.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Success state — the actual dashboard content
// ─────────────────────────────────────────────
class _SuccessView extends StatelessWidget {
  final CovidController controller;

  const _SuccessView({required this.controller});

  @override
  Widget build(BuildContext context) {
    final stats = controller.globalStats.value!;
    final hist = controller.historical.value;

    // Pull-to-refresh wraps the entire scrollable content
    return RefreshIndicator(
      color: AppTheme.primaryBlue,
      onRefresh: controller.fetchData,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
        children: [
          // Timestamp so users know how fresh the data is
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              'Updated: ${DateFormatter.fullDate(stats.updated)}',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              textAlign: TextAlign.right,
            ),
          ),

          // 2x2 grid of summary cards — compact and premium
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  label: 'Total Cases',
                  value: stats.cases,
                  color: const Color(0xFF1565C0),
                  icon: Icons.coronavirus_outlined,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatsCard(
                  label: 'Active',
                  value: stats.active,
                  color: const Color(0xFFFFA726),
                  icon: Icons.local_hospital_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: StatsCard(
                  label: 'Recovered',
                  value: stats.recovered,
                  color: const Color(0xFF66BB6A),
                  icon: Icons.favorite_outline,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatsCard(
                  label: 'Deaths',
                  value: stats.deaths,
                  color: const Color(0xFFEF5350),
                  icon: Icons.monitor_heart_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Donut chart — visual breakdown of active vs recovered vs deaths
          DistributionDonutChart(stats: stats),
          const SizedBox(height: 10),

          // Line chart — daily new cases trend over the past week
          if (hist != null) DailyLineChart(data: hist),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
