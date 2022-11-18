import 'dart:async';

class CounterBloc {
  final _stateStreamController = StreamController<int>();
  final _eventStreamController = StreamController();
  late int _counter;

  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  StreamSink get eventSink => _eventStreamController.sink;
  Stream get eventStream => _eventStreamController.stream;

  CounterBloc() {
    _counter = 0;
    // Continuing listening events
    eventStream.listen((event) {
      if (event == "increment") {
        _counter++;
      }
      if (event == "decrement") {
        _counter--;
      }
      // sink counter variable to Stream
      counterSink.add(_counter);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
