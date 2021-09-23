# Dynamic binding example
In this example there are two printers (`printer1` and `printer2`) and one printer manager. The printer manager accepts texte messages to be printed and forwards them to the selected printer that must be specified in the request message from the client. The printer manager dynamically binds the target printer before performing the call.

The printer services share the same code, just they have different configuration parameters. In order to run them, just run the following commands in two different consoles:

```
jolie --params printer1-parameter.json printer.ol

jolie --params printer2-parameter.json printer.ol
```

Then, uun the printer manager in a separate console with the following command:
```
jolie printer-manager.ol
```

Finally, run the client in a separate console and follow the instructions:
```
jolie client.ol

Insert the text to print
ciao 
Insert the printer name [printer1|printer2}
printer2
```
Look at the console of the related printer to see the text message printed.