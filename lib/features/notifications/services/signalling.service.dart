// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import 'package:ballaghny/core/utils/notifications_manager.dart';

// class PusherService {
//   final String? channelName;
//   PusherService({required this.channelName});
//   final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();
//   late String _apiKey;
//   late String _cluster;

//   /// Initialize Pusher
//   Future<void> initialize() async {
//     try {
//       // Load configurations from .env
//       _apiKey = dotenv.env['PUSHER_APP_KEY'] ?? '';
//       _cluster = dotenv.env['PUSHER_APP_CLUSTER'] ?? '';

//       if (_apiKey.isEmpty || _cluster.isEmpty || channelName == null) {
//         throw Exception("Missing Pusher configuration in .env");
//       }

//       log("Initializing Pusher with API Key: $_apiKey and Cluster: $_cluster");

//       // Initialize Pusher
//       await _pusher.init(
//         apiKey: _apiKey,
//         cluster: _cluster,
//         onConnectionStateChange: _onConnectionStateChange,
//         onError: _onError,
//         onSubscriptionSucceeded: _onSubscriptionSucceeded,
//         onEvent: _onEvent,
//         onSubscriptionError: _onSubscriptionError,
//         onDecryptionFailure: _onDecryptionFailure,
//         onMemberAdded: _onMemberAdded,
//         onMemberRemoved: _onMemberRemoved,
//         onSubscriptionCount: _onSubscriptionCount,
//       );

//       await connect();
//     } catch (e) {
//       log("Error initializing Pusher: $e");
//     }
//   }

//   /// Connect to Pusher
//   Future<void> connect() async {
//     try {
//       log("Connecting to Pusher...");
//       await _pusher.connect();
//       await subscribeToChannel();
//     } catch (e) {
//       log("Error connecting to Pusher: $e");
//     }
//   }

//   /// Disconnect from Pusher
//   Future<void> disconnect() async {
//     try {
//       log("Disconnecting from Pusher...");
//       await _pusher.disconnect();
//     } catch (e) {
//       log("Error disconnecting from Pusher: $e");
//     }
//   }

//   /// Subscribe to a channel
//   Future<void> subscribeToChannel() async {
//     try {
//       if (channelName == null) throw Exception("Channel name is not set");
//       log("Subscribing to channel: $channelName");
//       await _pusher.subscribe(channelName: channelName!);
//     } catch (e) {
//       log("Error subscribing to channel: $e");
//     }
//   }

//   /// Trigger an event on the channel
//   Future<void> triggerEvent(String eventName, dynamic data) async {
//     try {
//       if (channelName == null) throw Exception("Channel name is not set");
//       log("Triggering event: $eventName with data: $data on channel: $channelName");
//       await _pusher.trigger(
//         PusherEvent(
//           channelName: channelName!,
//           eventName: eventName,
//           data: data,
//         ),
//       );
//     } catch (e) {
//       log("Error triggering event: $e");
//     }
//   }

//   /// Show Notification
//   void _showNotification(String title, String body) {
//     NotificarionsManager.showNotification(
//       title: title,
//       body: body,
//     );
//   }

//   /// Event Handlers
//   void _onConnectionStateChange(dynamic currentState, dynamic previousState) {
//     log("Connection state changed: $currentState (from: $previousState)");
//   }

//   void _onError(String message, int? code, dynamic e) {
//     log("Error: $message (code: $code, exception: $e)");
//   }

//   void _onSubscriptionSucceeded(String channelName, dynamic data) {
//     log("Subscription succeeded: $channelName with data: $data");
//   }

//   void _onEvent(PusherEvent event) {
//     log("Event received: ${event.eventName} with data: ${event.data}");
//     if (event.data.isNotEmpty) {
//       _showNotification("New Notification", event.data.toString());
//     }
//   }

//   void _onSubscriptionError(String message, dynamic e) {
//     log("Subscription error: $message (exception: $e)");
//   }

//   void _onDecryptionFailure(String event, String reason) {
//     log("Decryption failure: $event (reason: $reason)");
//   }

//   void _onMemberAdded(String channelName, PusherMember member) {
//     log("Member added to $channelName: $member");
//   }

//   void _onMemberRemoved(String channelName, PusherMember member) {
//     log("Member removed from $channelName: $member");
//   }

//   void _onSubscriptionCount(String channelName, int subscriptionCount) {
//     log("Subscription count for $channelName: $subscriptionCount");
//   }
// }
