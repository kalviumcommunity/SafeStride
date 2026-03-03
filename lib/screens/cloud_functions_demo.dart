import 'package:flutter/material.dart';
import '../services/cloud_functions_service.dart';

class CloudFunctionsDemo extends StatefulWidget {
  const CloudFunctionsDemo({super.key});

  @override
  State<CloudFunctionsDemo> createState() => _CloudFunctionsDemoState();
}

class _CloudFunctionsDemoState extends State<CloudFunctionsDemo> {
  final CloudFunctionsService _functionsService = CloudFunctionsService();
  
  // State variables
  bool _isLoading = false;
  Map<String, dynamic>? _testResults;
  Map<String, dynamic>? _helloResult;
  Map<String, dynamic>? _validationResult;
  Map<String, dynamic>? _safetyScoreResult;
  Map<String, dynamic>? _healthCheckResult;
  Map<String, dynamic>? _routeStatsResult;
  List<String> _functionLogs = [];
  bool _functionsAvailable = false;

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _routeDistanceController = TextEditingController();
  final TextEditingController _routeTypeController = TextEditingController();
  final TextEditingController _routeSafetyController = TextEditingController();
  final TextEditingController _timeOfDayController = TextEditingController();
  final TextEditingController _weatherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkFunctionsAvailability();
    _loadFunctionLogs();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _routeNameController.dispose();
    _routeDistanceController.dispose();
    _routeTypeController.dispose();
    _routeSafetyController.dispose();
    _timeOfDayController.dispose();
    _weatherController.dispose();
    super.dispose();
  }

  Future<void> _checkFunctionsAvailability() async {
    setState(() => _isLoading = true);
    
    try {
      final available = await _functionsService.checkFunctionsAvailability();
      setState(() {
        _functionsAvailable = available;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error checking functions: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _loadFunctionLogs() async {
    try {
      final logs = await _functionsService.getFunctionLogs();
      setState(() => _functionLogs = logs);
    } catch (e) {
      print('Error loading logs: $e');
    }
  }

  Future<void> _testSayHello() async {
    if (_nameController.text.isEmpty) {
      _showError('Please enter a name');
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      final result = await _functionsService.sayHello(name: _nameController.text);
      setState(() {
        _helloResult = result;
        _isLoading = false;
      });
      
      _showSuccess('Hello function called successfully!');
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Error calling hello function: $e');
    }
  }

  Future<void> _testRouteValidation() async {
    if (_routeNameController.text.isEmpty || 
        _routeDistanceController.text.isEmpty ||
        _routeTypeController.text.isEmpty ||
        _routeSafetyController.text.isEmpty) {
      _showError('Please fill all route validation fields');
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      final routeData = {
        'name': _routeNameController.text,
        'distance': double.tryParse(_routeDistanceController.text) ?? 0.0,
        'type': _routeTypeController.text,
        'safetyRating': double.tryParse(_routeSafetyController.text) ?? 0.0,
      };
      
      final result = await _functionsService.validateRoute(routeData);
      setState(() {
        _validationResult = result;
        _isLoading = false;
      });
      
      if (result['isValid'] == true) {
        _showSuccess('Route validation passed!');
      } else {
        _showError('Route validation failed: ${result['errors'].join(', ')}');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Error validating route: $e');
    }
  }

  Future<void> _testSafetyScore() async {
    if (_routeTypeController.text.isEmpty || 
        _routeDistanceController.text.isEmpty ||
        _timeOfDayController.text.isEmpty ||
        _weatherController.text.isEmpty) {
      _showError('Please fill all safety score fields');
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      final result = await _functionsService.calculateSafetyScore(
        routeType: _routeTypeController.text,
        distance: double.tryParse(_routeDistanceController.text) ?? 0.0,
        timeOfDay: _timeOfDayController.text,
        weatherConditions: _weatherController.text,
      );
      
      setState(() {
        _safetyScoreResult = result;
        _isLoading = false;
      });
      
      _showSuccess('Safety score calculated: ${result['safetyScore']}');
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Error calculating safety score: $e');
    }
  }

  Future<void> _testHealthCheck() async {
    setState(() => _isLoading = true);
    
    try {
      final result = await _functionsService.healthCheck();
      setState(() {
        _healthCheckResult = result;
        _isLoading = false;
      });
      
      _showSuccess('Health check completed!');
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Error with health check: $e');
    }
  }

  Future<void> _testRouteStats() async {
    setState(() => _isLoading = true);
    
    try {
      final result = await _functionsService.getRouteStats();
      setState(() {
        _routeStatsResult = result;
        _isLoading = false;
      });
      
      _showSuccess('Route statistics retrieved!');
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Error getting route stats: $e');
    }
  }

  Future<void> _testAllFunctions() async {
    setState(() => _isLoading = true);
    
    try {
      final results = await _functionsService.testAllFunctions();
      setState(() {
        _testResults = results;
        _isLoading = false;
      });
      
      if (results.containsKey('error')) {
        _showError('Some functions failed: ${results['error']}');
      } else {
        _showSuccess('All functions tested successfully!');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Error testing functions: $e');
    }
  }

  void _showSuccess(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Functions Demo'),
        backgroundColor: Colors.deepPurple[600],
        foregroundColor: Colors.white,
        actions: [
          Icon(
            _functionsAvailable ? Icons.cloud_done : Icons.cloud_off,
            color: _functionsAvailable ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Firebase Cloud Functions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Test callable and event-based Cloud Functions. Functions execute server-side logic without managing servers.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.deepPurple[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        _functionsAvailable ? Icons.check_circle : Icons.error,
                        color: _functionsAvailable ? Colors.green : Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _functionsAvailable ? 'Functions Available' : 'Functions Unavailable',
                        style: TextStyle(
                          fontSize: 12,
                          color: _functionsAvailable ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Quick Test All Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _testAllFunctions,
                icon: _isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(_isLoading ? 'Testing...' : 'Test All Functions'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Individual Function Tests
            _buildFunctionTestSection(
              '1. Welcome Message (Callable)',
              'Test the basic sayHello callable function',
              [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Your Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _isLoading ? null : _testSayHello,
                  child: Text(_isLoading ? 'Calling...' : 'Call sayHello'),
                ),
                if (_helloResult != null) _buildResultCard('Hello Result', _helloResult!),
              ],
            ),

            const SizedBox(height: 24),

            _buildFunctionTestSection(
              '2. Route Validation (Callable)',
              'Validate route data against SafeStride requirements',
              [
                TextField(
                  controller: _routeNameController,
                  decoration: const InputDecoration(
                    labelText: 'Route Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _routeDistanceController,
                  decoration: const InputDecoration(
                    labelText: 'Distance (km)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _routeTypeController,
                  decoration: const InputDecoration(
                    labelText: 'Type (running/cycling/walking)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _routeSafetyController,
                  decoration: const InputDecoration(
                    labelText: 'Safety Rating (1-5)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _isLoading ? null : _testRouteValidation,
                  child: Text(_isLoading ? 'Validating...' : 'Validate Route'),
                ),
                if (_validationResult != null) _buildResultCard('Validation Result', _validationResult!),
              ],
            ),

            const SizedBox(height: 24),

            _buildFunctionTestSection(
              '3. Safety Score Calculation (Callable)',
              'Calculate safety score based on route conditions',
              [
                TextField(
                  controller: _timeOfDayController,
                  decoration: const InputDecoration(
                    labelText: 'Time of Day (morning/evening/night)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _weatherController,
                  decoration: const InputDecoration(
                    labelText: 'Weather (clear/rain/snow)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _isLoading ? null : _testSafetyScore,
                  child: Text(_isLoading ? 'Calculating...' : 'Calculate Safety Score'),
                ),
                if (_safetyScoreResult != null) _buildResultCard('Safety Score Result', _safetyScoreResult!),
              ],
            ),

            const SizedBox(height: 24),

            _buildFunctionTestSection(
              '4. Health Check (HTTP)',
              'Check if Cloud Functions are working',
              [
                ElevatedButton(
                  onPressed: _isLoading ? null : _testHealthCheck,
                  child: Text(_isLoading ? 'Checking...' : 'Health Check'),
                ),
                if (_healthCheckResult != null) _buildResultCard('Health Check Result', _healthCheckResult!),
              ],
            ),

            const SizedBox(height: 24),

            _buildFunctionTestSection(
              '5. Route Statistics (HTTP)',
              'Get aggregated statistics about routes',
              [
                ElevatedButton(
                  onPressed: _isLoading ? null : _testRouteStats,
                  child: Text(_isLoading ? 'Getting Stats...' : 'Get Route Stats'),
                ),
                if (_routeStatsResult != null) _buildResultCard('Route Statistics', _routeStatsResult!),
              ],
            ),

            const SizedBox(height: 24),

            // Function Logs
            Text(
              'Function Logs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[50],
              ),
              child: _functionLogs.isEmpty
                  ? const Center(child: Text('No logs available'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _functionLogs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            _functionLogs[index],
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 24),

            // All Test Results
            if (_testResults != null) ...[
              Text(
                'All Functions Test Results',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 12),
              _buildResultCard('Complete Test Results', _testResults!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFunctionTestSection(String title, String description, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildResultCard(String title, Map<String, dynamic> result) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(color: Colors.green[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          const SizedBox(height: 8),
          ...result.entries.map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${entry.key}: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                Expanded(
                  child: Text(
                    entry.value.toString(),
                    style: TextStyle(color: Colors.green[600]),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
