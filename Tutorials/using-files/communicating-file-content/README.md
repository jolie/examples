# Communicating the content of a file
In this example a client reads from a file `source.txt` and sends its content in a message targeting a service which appends it into a file called `received.txt`. In order to try th eexample run the following commands in different shells:

```
jolie server.ol
jolie client.ol
```
You can run the client more than one time. Each time the content of file `source.txt` will be appended into file `received.txt`.
Note that appending the content into an existing file is enabled by setting the parameter `append` of the `writeFile@File` to `1`.
