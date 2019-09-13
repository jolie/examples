# Invoking a web service
Try to extract the jolie interface from the wsdl definition `myWsdl.wsdl` saving it in file `generated_interface.iol`. Use the tool `wsdl2jolie` for achieving such a result:

```
wsdl2jolie myWsdl.wsdl generated_interface.iol
```
Then, run in separate shells the web service and the client:
```
jolie my_service.ol
```

```
jolie client_ws.ol
```

Note that `client_ws.ol` imports the generated file `generated_interface.iol`
