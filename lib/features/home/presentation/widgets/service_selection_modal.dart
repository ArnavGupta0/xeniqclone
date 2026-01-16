import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xeniqclone/features/auth/presentation/providers/auth_provider.dart';
import 'package:xeniqclone/features/call/services/call_request_service.dart';
import 'package:xeniqclone/features/session/presentation/screens/call_screen.dart' as session;
import 'dart:developer';

class ServiceSelectionModal extends StatelessWidget {
  final String providerId;
  final String providerCode; // New
  final String consumerId;
  final String consumerName; 

  const ServiceSelectionModal({
    super.key, 
    this.providerId = '',
    required this.providerCode,
    required this.consumerId,
    required this.consumerName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1F2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Specific Area',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildOption(
            context,
            icon: Icons.info_outline_rounded,
            title: 'Information Desk',
            color: const Color(0xFF3B82F6),
          ),
          const SizedBox(height: 16),
          _buildOption(
            context,
            icon: Icons.find_in_page_rounded,
            title: 'Lost & Found',
            color: const Color(0xFFF59E0B),
          ),
          const SizedBox(height: 16),
          _buildOption(
            context,
            icon: Icons.health_and_safety_rounded,
            title: 'Safety',
            color: const Color(0xFFEF4444),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Material(
      color: Colors.white.withOpacity(0.05),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () async {
          log('📞 [CONSUMER] Requesting call to provider: $providerCode');
          
          final response = await CallRequestService().requestCall(
            providerId: providerId, 
            providerCode: providerCode,
            consumerId: consumerId,
            consumerName: consumerName,
            purpose: title, 
          );
          
          if (!context.mounted) return;
          
          // Close modal first
          Navigator.pop(context);
          
          if (response.success && response.callId.isNotEmpty) {
            log('✅ [CONSUMER] Call requested successfully, call_id: ${response.callId}');
            log('🎬 [CONSUMER] Auto-joining session with call_id as sessionId');
            
            // Consumer IMMEDIATELY joins with callId as sessionId
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => session.CallScreen(
                  sessionId: response.callId,
                  isProvider: false,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(response.message.isNotEmpty ? response.message : 'Failed to request call')),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withOpacity(0.3),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
