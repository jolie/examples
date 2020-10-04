# Simple collection example
In this example two services, `Printer1` and `Printer2`, share the same interface `PrinterInterface`.
They are collected within the aggregator, thus it is possible to write a specific logics for delivering
the messages directed to them. In this particular case, the messages are delivered circularly to the two services.

Run the following services in different shells for testing the example:

- `jolie printer1.ol`
- `jolie printer2.ol`
- `jolie aggregator.ol`
- `jolie client.ol`
