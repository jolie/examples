# Recursion

The example of recursive call in Jolie is shown in `RecursiveCall.ol`. The module contains a service, namely `TreeService`, which gives an operation to perform a depth-indented listing of files on the given directory path, similar to the Linux's `tree` command.

The service consists of 3 communication ports which are `publicIP`, `selfIP`, and `selfOP`. The `publicIP` is defined with location `local` to expose available operations to the embedder service. While `selfIP` and `selfOP` are use for the internal communication.

The service required a argument to specify the root path for listing.
```
$ jolie -s main RecursiveCall.ol .
```