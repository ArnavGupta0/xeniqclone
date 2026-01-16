import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xeniqclone/features/auth/presentation/providers/auth_provider.dart';
import 'package:xeniqclone/features/provider/presentation/providers/provider_status_provider.dart';

class MenuDrawer extends ConsumerWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final user = userAsync.valueOrNull;

    // Dynamic User Data Logic
    final String userEmail = user?.email ?? '';
    // Use stored name, fallback to email username, then "User"
    final String userName = (user?.name != null && user!.name!.isNotEmpty) 
        ? user.name! 
        : (userEmail.isNotEmpty ? userEmail.split('@')[0] : 'User');

    return Drawer(
      backgroundColor: const Color(0xFF0F1115), // Deep dark background
      child: Column(
        children: [
          // 1. HEADER SECTION
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.05),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Logo + Badge + Toggle
                Consumer(
                  builder: (context, ref, _) {
                    final providerState = ref.watch(providerStatusProvider);
                    
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Side: Logo/Badge
                        Expanded(
                          child: Row(
                            children: [
                              // Initials/Logo Placeholder
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF3B82F6),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'X',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Xeniq',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        // 360 World Badge
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.2),
                                            ),
                                          ),
                                          child: const Text(
                                            '360 World',
                                            style: TextStyle(
                                              color: Color(0xFF9CA3AF),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // MANDATORY: Always log providerCode reads (ALL CASES)
                                    Builder(builder: (c) {
                                      final code = providerState.providerCode;
                                      final init = providerState.hasInitialized;
                                      final loading = providerState.isLoading;
                                      debugPrint('🎨 UI: Rendering providerCode = ${code ?? "null"}, hasInitialized = $init, isLoading = $loading');
                                      return const SizedBox.shrink(); // Invisible
                                    }),

                                    // STATE 1: Not initialized yet (Loading initial state)
                                    if (!providerState.hasInitialized) ...{
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white30)),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Initializing...',
                                              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    } 
                                    // STATE 2: Has provider code (Success - Always show code if available)
                                    else if (providerState.providerCode != null && providerState.providerCode!.isNotEmpty) ...{
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Code: ${providerState.providerCode}',
                                                  style: TextStyle(
                                                    color: providerState.providerCode!.startsWith('TEMP-') 
                                                        ? const Color(0xFFFFA500) // Orange for temp codes
                                                        : const Color(0xFF10B981), // Green for real codes
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Show "Syncing..." label for temp codes
                                            if (providerState.providerCode!.startsWith('TEMP-'))
                                              Padding(
                                                padding: const EdgeInsets.only(top: 2),
                                                child: Text(
                                                  '(Syncing with backend...)',
                                                  style: TextStyle(
                                                    color: Colors.white.withOpacity(0.4),
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    } 
                                    // STATE 3: Currently loading (after initialization, no code yet)
                                    else if (providerState.isLoading || providerState.registrationStatus == RegistrationStatus.registering) ...{
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white30)),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Fetching code...',
                                              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    } 
                                    // STATE 4: Failed (Only if no code and failed status)
                                    else if (providerState.registrationStatus == RegistrationStatus.failed) ...{
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          'Backend unreachable',
                                          style: const TextStyle(
                                            color: Color(0xFFEF4444), // Red
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    }
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Toggle Switch
                        Switch(
                          value: providerState.isAvailable,
                          onChanged: (v) async {
                            final notifier = ref.read(providerStatusProvider.notifier);
                            
                            if (v) {
                              // Turning ON: Request Permission First
                              final hasPermission = await notifier.requestLocationPermissionIfNeeded();
                              if (hasPermission) {
                                final uid = user?.id;
                                if (uid != null) {
                                  notifier.toggleAvailability(true, userId: uid);
                                } else {
                                  debugPrint('❌ Cannot toggle: user ID is null');
                                }
                              } else {
                                // Show Feedback
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Location permission is required to go online.'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            } else {
                              // Turning OFF: No permission needed
                              notifier.toggleAvailability(false);
                            }
                          },
                          activeColor: const Color(0xFF10B981),
                          activeTrackColor: const Color(0xFF10B981).withOpacity(0.2),
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                
                // User Details (Dynamic)
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName, // DYNAMIC NAME
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (userEmail.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                userEmail, // DYNAMIC EMAIL
                                style: const TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. MENU ITEMS
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _buildMenuItem(Icons.person_outline_rounded, 'Profile'),
                _buildMenuItem(Icons.account_balance_wallet_outlined, 'Wallet'),
                _buildMenuItem(Icons.link_rounded, 'LiveLinks'),
                _buildMenuItem(Icons.psychology_outlined, 'Expertise'),
                _buildMenuItem(Icons.call_outlined, 'Calls'),
                _buildMenuItem(Icons.dashboard_outlined, 'Referral Dashboard'),
                _buildMenuItem(Icons.business_outlined, 'Join a Business'),
                _buildMenuItem(Icons.play_circle_outline_rounded, 'App Demo'),
              ],
            ),
          ),

          // 3. FOOTER
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.05),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  Icons.report_problem_outlined,
                  'Report Issue',
                  textColor: const Color(0xFFEF4444),
                  iconColor: const Color(0xFFEF4444),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => ref.read(authRepositoryProvider).signOut(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white.withOpacity(0.2)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, {Color? textColor, Color? iconColor}) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? const Color(0xFF9CA3AF),
        size: 22,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: textColor ?? const Color(0xFFE5E7EB),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
