import 'package:driver_app/Model/NotificationModel.dart';
import 'package:driver_app/Repository/NotificationRepository.dart';
import 'package:rxdart/rxdart.dart';

class Notificationbloc {
  final BehaviorSubject<NotificationModel> notificationinfo =
      BehaviorSubject<NotificationModel>();
  final BehaviorSubject<int> unreadCount = BehaviorSubject<int>();

  final Notificationrepopsitory _notificationrepopsitory =
      Notificationrepopsitory();

  Future<NotificationModel> notificationdata() async {
    try {
      final responses = await _notificationrepopsitory.NotificationData();
      if (responses.result != null) {
        notificationinfo.sink.add(responses);

        // Update unread count
        final unread = responses.result!
            .where(
                (notification) => notification.notificationStatus == "UNREAD")
            .length;
        unreadCount.sink.add(unread);
      }
      return responses;
    } catch (e) {
      // Handle any exceptions
      return NotificationModel.withError('$e');
    }
  }

  Future<NotificationModel> updatenotificationdata(String notiid) async {
    try {
      final responses =
          await _notificationrepopsitory.updateNotificationData(notiid);
      if (responses.result != null) {
        notificationinfo.sink.add(responses);

        // Update unread count
        final unread = responses.result!
            .where(
                (notification) => notification.notificationStatus == "UNREAD")
            .length;
        unreadCount.sink.add(unread);
      }
      return responses;
    } catch (e) {
      // Handle any exceptions
      return NotificationModel.withError('$e');
    }
  }

  BehaviorSubject<NotificationModel> get getnotificationinfo =>
      notificationinfo;

  void markAllAsRead() {
    unreadCount.sink.add(0); // Reset unread count
  }

  void dispose() {
    notificationinfo.close();
    unreadCount.close();
  }
}

final notificationbloc = Notificationbloc();
