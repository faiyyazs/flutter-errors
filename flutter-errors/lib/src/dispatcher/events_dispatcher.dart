abstract class EventsDispatcher<Listener> {
  dispatchEvent(void Function(Listener listener) block);
}
