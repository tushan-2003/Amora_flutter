import 'dart:async';

import 'package:amora/models/model.dart';
import 'package:amora/repositories/database/database_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _chatSubscription;
  ChatBloc({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(ChatLoading()) {
    on<LoadChat>(_onLoadChat);
    on<UpdateChat>(_onUpdateChat);
    on<AddMessage>(_onAddMessage);
  }

  FutureOr<void> _onLoadChat(LoadChat event, Emitter<ChatState> emit) {
    _chatSubscription =
        _databaseRepository.getChat(event.chatId!).listen((chat) {
      add(UpdateChat(chat: chat));
    });
  }

  FutureOr<void> _onUpdateChat(UpdateChat event, Emitter<ChatState> emit) {
    emit(ChatLoaded(chat: event.chat));
  }

  FutureOr<void> _onAddMessage(AddMessage event, Emitter<ChatState> emit) {
    if (state is ChatLoaded) {
      final state = this.state as ChatLoaded;
      print("Event : ${event.userId}");
      final Message message = Message(
          senderId: event.userId,
          receiverId: event.macthedUserId,
          message: event.message,
          dateTime: DateTime.now(),
          timeString: DateFormat('HH:mm').format(DateTime.now()));

      _databaseRepository.addMessage(state.chat.id, message);
      emit(ChatLoaded(chat: state.chat));
    }
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
