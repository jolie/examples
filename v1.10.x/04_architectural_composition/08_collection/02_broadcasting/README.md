# Using collection for broadcasting messages
In this example two services, `Printer1` and `Printer2`, share the same interface `PrinterInterface`.
They are collected within the aggregator. In the courier process a parallel composition of forward activities
is used for broadcasting messages to the target services.

Run the following services in different shells for testing the example:

- `jolie printer1.ol`
- `jolie printer2.ol`
- `jolie aggregator.ol`
- `jolie client.ol`
