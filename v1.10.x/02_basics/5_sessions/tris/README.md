# The tris game
This is a simple implementation of the tris game in Jolie.

Run the game server with the following command:

`jolie tris.ol`

Run the two players in different shells, specifying the listening location as a constant in the command line, ex:

Player A (listening on port 10000): `jolie --params user1.json user.ol`

Player B (listening on port 10001): `jolie --params user2.json user.ol`
