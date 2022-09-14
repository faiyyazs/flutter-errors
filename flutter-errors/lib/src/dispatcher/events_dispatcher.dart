abstract class EventsDispatcher<Listener> {
  void dispatchEvent(void Function(Listener listener) block);
}
