import 'dart:async' show Timer;
import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/screens/doctor_appointement.dart';
import 'package:provider/provider.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart';
import 'package:mohammed_ashraf/core/dio/dio_client.dart';
import 'package:mohammed_ashraf/features/auth/models/appointment_model.dart';
import 'package:mohammed_ashraf/features/auth/providers/patient_appointment_filteration_provider.dart';
import 'package:intl/intl.dart';
import 'package:mohammed_ashraf/screens/filter_screen_doc.dart';
import 'package:mohammed_ashraf/screens/patient_report_screen.dart'as patient_report;

class AppointmentsListScreen extends StatefulWidget {
  const AppointmentsListScreen({super.key});

  @override
  State<AppointmentsListScreen> createState() => _AppointmentsListScreenState();
}

class _AppointmentsListScreenState extends State<AppointmentsListScreen> {
  late Future<List<Appointment>> _appointmentsFuture;
  final DioClient _dioClient = DioClient();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  String _searchQuery = '';
  int _currentPage = 1;
  final int _limit = 10;
  bool _hasMore = true;
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadInitialAppointments();
    _scrollController.addListener(_loadMoreAppointments);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounceTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchQuery = _searchController.text;
        _currentPage = 1;
        _hasMore = true;
        _appointmentsFuture = _fetchAppointments(page: 1);
      });
    });
  }

  void _loadInitialAppointments() {
    _appointmentsFuture = _fetchAppointments(page: 1);
  }

  Future<List<Appointment>> _fetchAppointments({required int page}) async {
    final filterProvider = context.read<PatientAppointmentFilterationProvider>();
    final filters = filterProvider.allFilters;

    try {
      final response = await _dioClient.getAppointments(
        status: filters['status'],
        timeFrame: filters['timeFrame'],
        searchQuery: _searchQuery,
        completed: true,
        page: page,
        limit: _limit,
        sort: 'estimated',
        fields: 'title,completed,estimated,status,startTime,endTime,doctor,patient,payment',
      );

      final List data = response['data'];
      final totalResults = response['results'];

      setState(() {
        _hasMore = (page * _limit) < totalResults;
      });

      return data.map((json) => Appointment.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load appointments: $e');
    }
  }

  Future<void> _loadMoreAppointments() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent &&
        _hasMore) {
      try {
        final nextPage = _currentPage + 1;
        final newAppointments = await _fetchAppointments(page: nextPage);

        setState(() {
          _appointments.addAll(newAppointments);
          _currentPage = nextPage;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load more appointments: $e')));
      }
    }
  }

  Future<void> _refreshAppointments() async {
    setState(() {
      _currentPage = 1;
      _hasMore = true;
    });
    _appointmentsFuture = _fetchAppointments(page: 1);
  }

  String _formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  String _formatDate(DateTime time) {
    return DateFormat('MMM dd, yyyy').format(time);
  }

  String _formatStatus(String status) {
    return status[0].toUpperCase() + status.substring(1);
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      case 'booked':
        return Colors.blueAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments', style: TextStyle(color: AppColors.textColor)),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: Consumer<PatientAppointmentFilterationProvider>(
        builder: (context, filterProvider, _) {
          return Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: TextField(
              //           controller: _searchController,
              //           decoration: InputDecoration(
              //             hintText: 'Search by patient name...',
              //             prefixIcon: const Icon(
              //               Icons.search,
              //               color: AppColors.primaryColor,
              //             ),
              //             filled: true,
              //             fillColor: Colors.grey[100],
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(12.0),
              //               borderSide: BorderSide.none,
              //             ),
              //             focusedBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(12.0),
              //               borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
              //             ),
              //             contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              //             suffixIcon: _searchController.text.isNotEmpty
              //                 ? IconButton(
              //               icon: const Icon(Icons.clear),
              //               onPressed: () {
              //                 _searchController.clear();
              //                 setState(() {
              //                   _searchQuery = '';
              //                   _currentPage = 1;
              //                   _hasMore = true;
              //                   _appointmentsFuture = _fetchAppointments(page: 1);
              //                 });
              //               },
              //             )
              //                 : null,
              //           ),
              //         ),
              //       ),
              //       const SizedBox(width: 10),
              //       InkWell(
              //         onTap: () async {
              //           final filtersApplied = await Navigator.push<bool>(
              //             context,
              //             MaterialPageRoute(builder: (context) => const FilterScreenDoctor()),
              //           );
              //
              //           if (filtersApplied == true) {
              //             _refreshAppointments();
              //           }
              //         },
              //         borderRadius: BorderRadius.circular(12.0),
              //         child: Container(
              //           padding: const EdgeInsets.all(13.0),
              //           decoration: BoxDecoration(
              //             color: filterProvider.hasActiveFilters
              //                 ? AppColors.primaryColor.withOpacity(0.2)
              //                 : Colors.grey[100],
              //             borderRadius: BorderRadius.circular(12),
              //             border: Border.all(
              //               color: filterProvider.hasActiveFilters
              //                   ? AppColors.primaryColor
              //                   : Colors.transparent,
              //               width: 1.5,
              //             ),
              //           ),
              //           child: Icon(
              //             Icons.filter_list,
              //             color: filterProvider.hasActiveFilters
              //                 ? AppColors.primaryColor
              //                 : AppColors.textColor,
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshAppointments,
                  child: FutureBuilder<List<Appointment>>(
                    future: _appointmentsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting && _currentPage == 1) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return ListView(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height / 4),
                            const Center(
                              child: Column(
                                children: [
                                  Icon(Icons.calendar_today, size: 64, color: Colors.grey),
                                  SizedBox(height: 16),
                                  Text(
                                    'No appointments found',
                                    style: TextStyle(fontSize: 18, color: Colors.grey),
                                  ),
                                  Text(
                                    'Try changing your filters or search',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }

                      if (_currentPage == 1) {
                        _appointments = snapshot.data!;
                      }

                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: _appointments.length + (_hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= _appointments.length) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          final appointment = _appointments[index];
                          final patient = appointment.patient;
                          final payment = appointment.payment;

                          return PatientCard(
                            imageUrl: appointment.doctor?.profileImg ?? 'https://via.placeholder.com/150',
                            name: '${patient?.firstName ?? 'Unknown'} ${patient?.lastName ?? 'Patient'}',
                            date: appointment.startTime != null
                                ? _formatDate(appointment.startTime!)
                                : 'No date',
                            time: appointment.startTime != null && appointment.endTime != null
                                ? '${_formatTime(appointment.startTime!)} - ${_formatTime(appointment.endTime!)}'
                                : 'Time not specified',
                            status: _formatStatus(appointment.status),
                            statusColor: _statusColor(appointment.status),
                            paymentStatus: payment?.status ?? 'N/A',
                            fee: appointment.doctor?.appointmentFee != null
                                ? '\$${appointment.doctor!.appointmentFee}'
                                : 'N/A',
                            onViewDetails: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppointmentDetailScreen(
                                    appointment: appointment,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PatientCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String date;
  final String time;
  final String status;
  final Color statusColor;
  final String paymentStatus;
  final String fee;
  final VoidCallback onViewDetails;

  const PatientCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.date,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.paymentStatus,
    required this.fee,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(imageUrl),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            time,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.payment, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            paymentStatus,
                            style: TextStyle(
                              color: paymentStatus == 'pending'
                                  ? Colors.orange
                                  : Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '• $fee',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 20),
                  onPressed: onViewDetails,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentDetailScreen extends StatelessWidget {
  final Appointment appointment;

  const AppointmentDetailScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final patient = appointment.patient;
    final doctor = appointment.doctor;
    final payment = appointment.payment;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailSection(
              'Patient Information',
              [
                _buildDetailRow('Name', '${patient?.firstName} ${patient?.lastName}'),
                _buildDetailRow('ID', patient?.id ?? 'N/A'),
              ],
            ),

            const SizedBox(height: 24),

            _buildDetailSection(
              'Appointment Details',
              [
                _buildDetailRow('Date', appointment.startTime != null
                    ? DateFormat.yMMMd().format(appointment.startTime!)
                    : 'N/A'),
                _buildDetailRow('Time', appointment.startTime != null && appointment.endTime != null
                    ? '${DateFormat.jm().format(appointment.startTime!)} - ${DateFormat.jm().format(appointment.endTime!)}'
                    : 'N/A'),
                _buildDetailRow('Status', appointment.status),
                _buildDetailRow('Reference ID', appointment.id),
              ],
            ),

            const SizedBox(height: 24),

            _buildDetailSection(
              'Medical Professional',
              [
                _buildDetailRow('Doctor', 'Dr. ${doctor?.firstName} ${doctor?.lastName}'),
              //  _buildDetailRow('Specialty', 'Neurologist'), // Update with actual specialty
                _buildDetailRow('Fee', doctor?.appointmentFee != null
                    ? '\$${doctor!.appointmentFee}'
                    : 'N/A'),
              ],
            ),

            const SizedBox(height: 24),

            _buildDetailSection(
              'Payment Information',
              [
                _buildDetailRow('Status', payment?.status ?? 'N/A'),
                _buildDetailRow('Transaction ID', payment?.stripeSessionId ?? 'N/A'),
                _buildDetailRow('Amount', doctor?.appointmentFee != null
                    ? '\$${doctor!.appointmentFee}'
                    : 'N/A'),
              ],
            ),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => patient_report.PatientReportScreen(patientId: patient.id),));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('View Medical Report',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$title:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}