import 'package:flutter/material.dart';
import '../../utils/bottom_bar.dart';
import 'programme_details_screen.dart';

class ProgrammeScreen extends StatefulWidget {
  const ProgrammeScreen({super.key});

  @override
  State<ProgrammeScreen> createState() => _ProgrammeScreenState();
}

class _ProgrammeScreenState extends State<ProgrammeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Add listener to update UI when tab changes due to gestures
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Programme',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
                _buildTabButton(0, 'UG: Undergraduate'),
                const SizedBox(width: 8),
                _buildTabButton(1, 'PG: Post Graduate'),
                const SizedBox(width: 8),
                _buildTabButton(2, 'PhD: Doctor of Philosophy'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              // Adding smooth physics for better scrolling experience
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: const [
                UGProgrammeTab(),
                PGProgrammeTab(),
                PhDProgrammeTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget _buildTabButton(int index, String label) {
    bool isSelected = _tabController.index == index;

    return GestureDetector(
      onTap: () {
        // Animate to tab with a smoother animation
        _tabController.animateTo(
          index,
          duration: const Duration(
              milliseconds: 350), // Slightly longer duration for smoother feel
          curve: Curves.easeInOut, // Smoother animation curve
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

class UGProgrammeTab extends StatelessWidget {
  const UGProgrammeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ProgrammeTabContent(
      programmes: const [
        {
          'programme': 'B.Tech ECE',
          'discipline': 'Electronics and Communication Engineering'
        },
        {'programme': 'B.Tech ME', 'discipline': 'Mechanical Engineering'},
        {'programme': 'B.Design', 'discipline': 'Design'},
        {'programme': 'B.Tech SM', 'discipline': 'Smart Manufacturing'},
        {'programme': 'B.Tech CSE', 'discipline': ''},
      ],
    );
  }
}

class PGProgrammeTab extends StatelessWidget {
  const PGProgrammeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ProgrammeTabContent(
      programmes: const [
        {
          'programme': 'M.Tech ECE',
          'discipline': 'Electronics and Communication Engineering'
        },
        {
          'programme': 'M.Tech CSE',
          'discipline': 'Computer Science and Engineering'
        },
        {'programme': 'M.Tech ME', 'discipline': 'Mechanical Engineering'},
        {'programme': 'M.Des Design', 'discipline': 'Design'},
        {'programme': 'M. Tech Mechatronics', 'discipline': 'Mechatronics'},
        {'programme': 'M.Tech SM', 'discipline': 'Smart Manufacturing'},
      ],
    );
  }
}

class PhDProgrammeTab extends StatelessWidget {
  const PhDProgrammeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ProgrammeTabContent(
      programmes: const [
        {
          'programme': 'PhD in ECE',
          'discipline': 'Electronics and Communication Engineering'
        },
        {
          'programme': 'PhD in CSE',
          'discipline': 'Computer Science and Engineering'
        },
        {'programme': 'PhD in ME', 'discipline': 'Mechanical Engineering'},
        {'programme': 'PhD in Design', 'discipline': 'Design'},
        {
          'programme': 'PhD in Maths',
          'discipline': 'Natural Sciences-Mathematics'
        },
        {
          'programme': 'PhD in Physics',
          'discipline': 'Natural Sciences-Physics'
        },
        {'programme': 'PhD in English', 'discipline': 'Humanities - English'},
      ],
    );
  }
}

class ProgrammeTabContent extends StatefulWidget {
  final List<Map<String, String>> programmes;

  const ProgrammeTabContent({super.key, required this.programmes});

  @override
  State<ProgrammeTabContent> createState() => _ProgrammeTabContentState();
}

class _ProgrammeTabContentState extends State<ProgrammeTabContent> {
  late List<Map<String, String>> filteredProgrammes;
  final TextEditingController _programmeController = TextEditingController();
  final TextEditingController _disciplineController = TextEditingController();
  final FocusNode _programmeFocusNode = FocusNode();
  final FocusNode _disciplineFocusNode = FocusNode();
  bool _isProgrammeFocused = false;
  bool _isDisciplineFocused = false;

  @override
  void initState() {
    super.initState();
    filteredProgrammes = List.from(widget.programmes);
    _programmeFocusNode.addListener(_onProgrammeFocusChange);
    _disciplineFocusNode.addListener(_onDisciplineFocusChange);
  }

  @override
  void dispose() {
    _programmeController.dispose();
    _disciplineController.dispose();
    _programmeFocusNode.removeListener(_onProgrammeFocusChange);
    _disciplineFocusNode.removeListener(_onDisciplineFocusChange);
    _programmeFocusNode.dispose();
    _disciplineFocusNode.dispose();
    super.dispose();
  }

  void _onProgrammeFocusChange() {
    setState(() {
      _isProgrammeFocused = _programmeFocusNode.hasFocus;
    });
  }

  void _onDisciplineFocusChange() {
    setState(() {
      _isDisciplineFocused = _disciplineFocusNode.hasFocus;
    });
  }

  void _filterProgrammes() {
    final programmeQuery = _programmeController.text.toLowerCase();
    final disciplineQuery = _disciplineController.text.toLowerCase();

    setState(() {
      filteredProgrammes = widget.programmes.where((programme) {
        final programmeMatch =
            programme['programme']!.toLowerCase().contains(programmeQuery);
        final disciplineMatch =
            programme['discipline']!.toLowerCase().contains(disciplineQuery);
        return programmeMatch && disciplineMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Programme:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _programmeController,
              focusNode: _programmeFocusNode,
              onChanged: (_) => _filterProgrammes(),
              decoration: InputDecoration(
                hintText: 'Search by Programme',
                prefixIcon: Icon(
                  Icons.search,
                  color: _isProgrammeFocused ? Colors.deepPurple : Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide:
                      const BorderSide(color: Colors.deepPurple, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 14.0),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Discipline:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _disciplineController,
              focusNode: _disciplineFocusNode,
              onChanged: (_) => _filterProgrammes(),
              decoration: InputDecoration(
                hintText: 'Search by Discipline',
                prefixIcon: Icon(
                  Icons.search,
                  color: _isDisciplineFocused ? Colors.deepPurple : Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide:
                      const BorderSide(color: Colors.deepPurple, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 14.0),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Programme',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Discipline',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Table Rows
                  if (filteredProgrammes.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: const Text(
                        "No programmes match your filter criteria",
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  else
                    ...filteredProgrammes.asMap().entries.map((entry) {
                      final index = entry.key;
                      final programme = entry.value;
                      return Container(
                        decoration: BoxDecoration(
                          color:
                              index.isEven ? Colors.grey.shade50 : Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextButton(
                                  onPressed: () {
                                    // Navigate to programme details screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProgrammeDetailsScreen(
                                          programmeName:
                                              programme['programme']!,
                                        ),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                    foregroundColor: Colors.blue,
                                  ),
                                  child: Text(programme['programme']!),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(programme['discipline']!),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
