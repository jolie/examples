include "console.iol"
include "string_utils.iol"
include "MyServiceInterface.iol"

execution{ concurrent }

inputPort MyServiceSOAPPort {
    Location: "socket://localhost:8001"
    Protocol: soap {
        .wsdl = "myWsdl.wsdl";
        .wsdl.port = "MyServiceSOAPPortServicePort"
    }
    Interfaces: MyServiceInterface
}

main {
    getAddress( request )( response ) {
        if (  request.person.name == "Homer" &&
            request.person.surname == "Simpsons" ) {
            with( response.address ) {
                .country = "USA";
                .city = "Springfield";
                .zip_code = "01101";
                .street = "Evergreen Terrace";
                .number = "742"
            }
        } else {
            with( fault.person ) {
                .name = request.person.name;
                .surname = request.person.surname
            };
            throw( NameDoesNotExist, fault )
        }
    }
}