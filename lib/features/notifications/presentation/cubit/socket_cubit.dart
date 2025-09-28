import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<void> {
  // final SocketService _socketService;
  // final GetSavedLoginCredentials getSavedLoginCredentialsUseCase;

  SocketCubit(
      // this._socketService, this.getSavedLoginCredentialsUseCase,
      )
      : super(null);

  // void connect() {
  //   final String url = dotenv.env['SOCKET_URL'] ?? '';

  //   log("SocketCubit: Attempting to connect to Socket.IO...", name: url);

  //   _socketService.init();
  // }

  // void joinChannel(String channelName) {
  //   _socketService.subscribeToChannel(channelName);
  // }

  // void listenToEvent(String event, Function(dynamic) callback) {
  //   _socketService.subscribeToEvent(event, callback);
  // }

  // void emitEvent(String event, dynamic data) {
  //   _socketService.sendEvent(event, data);
  // }

  // void disconnect() {
  //   _socketService.disconnect();
  // }
}
