# Transparent protocol transformation
In this example the redirector exposes a port using protocol `sodep` but it internally redirect messages using protocol `http`. Sub services `sum` and `sub` indeed, uses protocol `http`for receiving messages.

Try to run the example running the following services in different shells:
* `jolie sum.ol`
* `jolie sub.ol`
* `jolie redirector.ol`
* `jolie client.ol 1 2` (where `1` and `2` are the input parameters)
