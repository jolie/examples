# Dynamic embedding
In this example the service `calculator.ol` dynamically embeds the operation to be executed ( _sum_ | _sub_ | _div_ | _mul_ ) whose implementation is sent by the client. The client retrieves the implementation of the operation reading from different files: `sum.ol` | `sub.ol` | `div.ol` | `mul.ol`. Note that all the microservices to be dynamically embedded share the same interface `OperationInterface`.

In order to try the example:
- in a shell run `jolie calculator.ol`
- in another shell run the client with the command `jolie client.ol` then follows the instructions in the console.