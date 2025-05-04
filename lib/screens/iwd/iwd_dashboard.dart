import 'package:flutter/material.dart';
import 'create_request.dart';
import 'request_status.dart';
import 'create_proposal.dart';
import 'view_proposal_tables.dart';
import 'issue_work_order.dart';
import 'view_budget.dart';
import 'manage_budget.dart';
import 'approve_reject_request.dart';
import 'audit_document.dart';
import '../../utils/sidebar.dart';
import '../../utils/gesture_sidebar.dart';
import '../../utils/bottom_bar.dart';

class IwdDashboardScreen extends StatefulWidget {
  const IwdDashboardScreen({super.key});

  @override
  State<IwdDashboardScreen> createState() => _IwdDashboardScreenState();
}

class _IwdDashboardScreenState extends State<IwdDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<String, List<_SubSection>> sections = {
    'Request': [
      _SubSection('Create Request', Icons.add_circle_outline,
          const CreateRequestScreen()),
      _SubSection(
          'Request Status', Icons.query_stats, const RequestStatusPage()),
      _SubSection('Approve/Reject Requests', Icons.check_circle_outline,
          const ApproveRequestsPage()),
    ],
    'Proposal': [
      _SubSection('Create Proposal', Icons.description_outlined,
          const NewProposalPage()),
      _SubSection(
          'View Proposals', Icons.table_view, const ViewProposalTablesPage()),
    ],
    'Work Orders': [
      _SubSection('Issue Work Order', Icons.assignment_turned_in,
          const IssueWorkOrderPage()),
    ],
    'Budget': [
      _SubSection(
          'View Budget', Icons.pie_chart_outline, const ViewBudgetPage()),
      _SubSection(
          'Manage Budget', Icons.manage_accounts, const ManageBudgetPage()),
    ],
    'Audit Documents': [
      _SubSection('Audit Documents', Icons.upload_file, const AuditDocumentsPage()),
    ],
  };

  final Set<String> _expandedSections = {};

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const Sidebar(), // Left-side drawer
      backgroundColor: colors.surfaceVariant,
      appBar: AppBar(
        title: const Text('IWD Dashboard'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer(); // We use left drawer
            },
          ),
        ],
      ),
      body: GestureSidebar(
        scaffoldKey: _scaffoldKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _buildSection(context, sections.keys.elementAt(index)),
                  childCount: sections.length,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(currentIndex: 2),
    );
  }

  Widget _buildSection(BuildContext context, String sectionKey) {
    final colors = Theme.of(context).colorScheme;
    final isExpanded = _expandedSections.contains(sectionKey);
    final sectionItems = sections[sectionKey]!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: const Border(),
          collapsedShape: const Border(),
          onExpansionChanged: (expanded) => setState(() {
            if (expanded) {
              _expandedSections.add(sectionKey);
            } else {
              _expandedSections.remove(sectionKey);
            }
          }),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getSectionColor(sectionKey).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getSectionIcon(sectionKey),
              color: _getSectionColor(sectionKey),
              size: 28,
            ),
          ),
          title: Text(
            sectionKey,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colors.onSurface,
              letterSpacing: 0.5,
            ),
          ),
          trailing: Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
            color: colors.onSurface.withOpacity(0.6),
          ),
          children: [
            if (sectionItems.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: sectionItems
                      .map((item) => _buildSubSectionItem(context, item))
                      .toList(),
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('No items available.'),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildSubSectionItem(BuildContext context, _SubSection item) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => item.page),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.outline.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(item.icon, color: Colors.blue, size: 32),
            const SizedBox(height: 12),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'View details',
              style: TextStyle(
                fontSize: 12,
                color: colors.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSectionColor(String section) {
    final index = sections.keys.toList().indexOf(section);
    final colors = [
      const Color(0xFF3B82F6), // Blue
      const Color(0xFF10B981), // Green
      const Color(0xFFF59E0B), // Amber
      const Color(0xFFEF4444), // Red
      const Color(0xFF8B5CF6), // Violet
    ];
    return colors[index % colors.length];
  }

  IconData _getSectionIcon(String section) {
    switch (section) {
      case 'Request':
        return Icons.request_quote;
      case 'Proposal':
        return Icons.assignment;
      case 'Work Orders':
        return Icons.work_outline;
      case 'Budget':
        return Icons.account_balance_wallet;
      case 'Audit Documents':
        return Icons.folder_special;
      default:
        return Icons.category;
    }
  }
}

class _SubSection {
  final String title;
  final IconData icon;
  final Widget page;

  _SubSection(this.title, this.icon, this.page);
}
