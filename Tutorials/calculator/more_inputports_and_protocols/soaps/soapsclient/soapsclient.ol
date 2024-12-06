include "AdvancedCalculatorInterface.ol"

main {
    with( request ) {
        .term[0] = 1;
        .term[1] = 2;
        .term[2] = 3
    }
    average@AdvancedCalculatorPortSOAPServicePort( request )( response )
}