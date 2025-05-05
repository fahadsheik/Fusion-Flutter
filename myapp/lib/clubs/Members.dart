import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Member {
  final String memberId;
  final String club;
  final String? description;
  final String status;
  final String? remarks;
  final int id;

  Member({
    required this.memberId,
    required this.club,
    this.description,
    required this.status,
    this.remarks,
    required this.id,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberId: json['member'],
      club: json['club'],
      description: json['description'],
      status: json['status'],
      remarks: json['remarks'],
      id: json['id'],
    );
  }
}

class MembersPage extends StatefulWidget {
  final String token;

  const MembersPage({super.key, required this.token});

  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  List<Member> _members = [];
  String? _selectedClub;
  bool _isLoading = false;
  String _errorMessage = '';

  final List<String> _clubs = [
    'BitByte',
    'Aero Club',
    'Robotics Club',
    'Cultural Club',
    'Sports Club'
  ];

  Future<void> _fetchMembers() async {
    if (_selectedClub == null) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/gymkhana/api/members_records/'),
        headers: {
          'Authorization': 'Token ${widget.token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'club_name': _selectedClub}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _members = data.map((item) => Member.fromJson(item)).toList();
        });
      } else {
        throw Exception('Failed to load members: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Members'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: _selectedClub,
              hint: const Text('Select Club'),
              items: _clubs.map((String club) {
                return DropdownMenuItem<String>(
                  value: club,
                  child: Text(club),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() => _selectedClub = newValue);
                _fetchMembers();
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Colors.blue, width: 10)),
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_errorMessage.isNotEmpty) {
      return Center(child: Text(_errorMessage));
    }

    if (_selectedClub == null) {
      return const Center(child: Text('Please select a club from the dropdown'));
    }

    if (_members.isEmpty) {
      return const Center(child: Text('No members found for this club'));
    }

    return RefreshIndicator(
      onRefresh: _fetchMembers,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _members.length,
        itemBuilder: (context, index) {
          final member = _members[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(member.memberId),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status: ${member.status}'),
                  if (member.description != null)
                    Text('Description: ${member.description}'),
                  if (member.remarks != null)
                    Text('Remarks: ${member.remarks}'),
                ],
              ),
              trailing: Text('#${member.id}'),
            ),
          );
        },
      ),
    );
  }
}