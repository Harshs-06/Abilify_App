import 'package:url_launcher/url_launcher.dart';

class EmailUtils {
  static Future<void> launchBookingEmail({
    required String serviceName,
    required String providerName,
    String? recipient,
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: recipient ?? 'booking@abilify.com',
      query: _encodeQueryParameters({
        'subject': 'Booking Request: $serviceName with $providerName',
        'body': '''
Dear $providerName,

I would like to request an appointment for $serviceName services through the Abilify app. Please let me know your availability for a consultation.

Thank you,
[Your Name]
        '''
      }),
    );
    
    await _launchUrl(emailLaunchUri);
  }
  
  static Future<void> launchContactEmail({
    required String serviceName,
    required String providerName,
    String? recipient,
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: recipient ?? 'contact@abilify.com',
      query: _encodeQueryParameters({
        'subject': 'Inquiry about: $providerName ($serviceName)',
        'body': '''
Dear $providerName,

I found your profile on the Abilify app and I'm interested in learning more about your $serviceName services. Could you please provide more information about your services, availability, and rates?

Thank you,
[Your Name]
        '''
      }),
    );
    
    await _launchUrl(emailLaunchUri);
  }
  
  static Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  
  static String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
} 