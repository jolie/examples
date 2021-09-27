# A simple chat
In this example a simple chat scenario is addressed. The `chat-registy.ol` keeps the registry of all the chats and the list of all the users connected with them. Every time a message is sent to the chat, the registry will forward ot to all the members of the chat (with the exception of the sender).


* Chat Registry is executed running the following example:

  `jolie chat-registry.ol`

The user application is defined into module `user.ol`. It is composed of two services: service `User` just provodes the console interface to the user for inserting messages; service `UserListener` waits for messages from the `chat-registry` and print them out in the console.

* multiple `user.ol` can be run for enabling different users, just exploit a different parameter file. In the example folder there are three different parameter files for testing three different users concurrently. Run each user in a separate shell using the following command:

  `jolie user.ol --params <parameter-file.json> -s User user.ol`

example:

`jolie --params params-user1.json -s User user.ol`

