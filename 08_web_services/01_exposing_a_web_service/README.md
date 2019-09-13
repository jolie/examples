# Exposing a web service
Try to generate the wsdl definition using the tool `jolie2wsdl` as it follows:

```
jolie2wsdl --namespace jolie.test --portName MyServiceSOAPPort --portAddr http://localhost:8001 --outputFile myWsdl.wsdl my_service.ol
```

Then, add the wsdl definition as parameter of the soap protocol within the input port of service `my_service.ol`:
```
inputPort MyServiceSOAPPort {
    Location: "socket://localhost:8001"
    Protocol: soap {
        .wsdl = "myWsdl.wsdl";
        .wsdl.port = "MyServiceSOAPPortServicePort"
    }
    Interfaces: MyServiceInterface
}
```