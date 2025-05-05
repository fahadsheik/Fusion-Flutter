import 'package:flutter/material.dart';
import 'curriculum_detail_screen.dart';

class ProgrammeDetailsScreen extends StatefulWidget {
  final String programmeName;

  const ProgrammeDetailsScreen({Key? key, required this.programmeName})
      : super(key: key);

  @override
  State<ProgrammeDetailsScreen> createState() => _ProgrammeDetailsScreenState();
}

class _ProgrammeDetailsScreenState extends State<ProgrammeDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.programmeName,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12.0, bottom: 8.0),
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              children: [
                _buildTabButton(0, 'Programme Info'),
                const SizedBox(width: 8),
                _buildTabButton(1, 'Working Curriculums'),
                const SizedBox(width: 8),
                _buildTabButton(2, 'Obsolete Curriculums'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                _ProgrammeInfoTab(programmeName: widget.programmeName),
                _WorkingCurriculumsTab(programmeName: widget.programmeName),
                _ObsoleteCurriculumsTab(programmeName: widget.programmeName),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, String label) {
    bool isSelected = _tabController.index == index;

    return GestureDetector(
      onTap: () {
        _tabController.animateTo(
          index,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ProgrammeInfoTab extends StatelessWidget {
  final String programmeName;

  const _ProgrammeInfoTab({required this.programmeName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Colors.blue.shade100,
            child: Text(
              'B.Tech ECE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
            },
            children: [
              _buildTableRow('Programme Name', 'B.Tech ECE', false),
              _buildTableRow('Programme Category', 'UG', true),
              _buildTableRow('Programme Begin Year', '2021', false),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String key, String value, bool isAlternateRow) {
    return TableRow(
      decoration: BoxDecoration(
        color: isAlternateRow ? Colors.blue.shade50 : Colors.white,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Text(
            key,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Text(value),
        ),
      ],
    );
  }
}

class _WorkingCurriculumsTab extends StatelessWidget {
  final String programmeName;

  const _WorkingCurriculumsTab({required this.programmeName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            color: Colors.blue.shade100,
            child: Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(4),
                3: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  children: [
                    _buildHeaderCell('Name'),
                    _buildHeaderCell('Version'),
                    _buildHeaderCell('Batch'),
                    _buildHeaderCell('No. of Semesters'),
                  ],
                ),
              ],
            ),
          ),
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(4),
              3: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                children: [
                  _buildNameCell('ECE UG Curriculum', true, context),
                  _buildCell('1.0'),
                  _buildCell(
                      'B.Tech 2016  |  B.Tech 2017  |  B.Tech 2018  |  B.Tech 2019  |  B.Tech 2020  |  B.Tech 2021  |  Phd 2022  |  B.Tech 2022'),
                  _buildCell('8'),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                ),
                children: [
                  _buildNameCell('ECE UG Curriculum 2', false, context),
                  _buildCell('1.0'),
                  _buildCell(''),
                  _buildCell('8'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade700,
        ),
      ),
    );
  }

  Widget _buildCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(text),
    );
  }

  Widget _buildNameCell(String text, bool isFirst, BuildContext context) {
    return InkWell(
      onTap: () {
        print("Navigating to $text detail screen");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CurriculumDetailScreen(curriculumName: text),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class _ObsoleteCurriculumsTab extends StatelessWidget {
  final String programmeName;

  const _ObsoleteCurriculumsTab({required this.programmeName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            color: Colors.blue.shade100,
            child: Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(4),
                3: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  children: [
                    _buildHeaderCell('Name'),
                    _buildHeaderCell('Version'),
                    _buildHeaderCell('Batch'),
                    _buildHeaderCell('No. of Semesters'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Center(
              child: Text(
                'No results found',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade700,
        ),
      ),
    );
  }
}

class CurriculumDetailScreen extends StatelessWidget {
  final String curriculumName;

  const CurriculumDetailScreen({Key? key, required this.curriculumName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(curriculumName),
      ),
      body: Center(
        child: Text('Details for $curriculumName'),
      ),
    );
  }
}
