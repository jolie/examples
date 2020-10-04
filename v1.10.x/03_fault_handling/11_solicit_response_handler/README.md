# Solicit-Response handler

In this example we show how to install a termination handler after sending a request in a Solicit-Response.
Run in different shells the following commands:

* `jolie server.ol`
* `jolie client.ol`

Note that the server can be run specifying if is must reply with a fault to the received request. In such a case run the server as follows:

* `jolie server.ol fault`

Moreover, the client can be run specifying how many milliseconds to wait before raising the internal fault. In such a case run the client as it follows:

* `jolie client.ol 5000`

where 5000 are the milliseconds to wait.
