package org.jolie.example;

import jolie.net.CommMessage;
import jolie.runtime.FaultException;
import jolie.runtime.JavaService;
import jolie.runtime.Value;

public class FirstJavaService extends JavaService
{
	public Value HelloWorld( Value request ) throws FaultException {
		String message = request.getFirstChild( "message" ).strValue();
		System.out.println( message );
		if ( !message.equals( "I am Luke" ) ) {
			Value faultMessage = Value.create();
			faultMessage.getFirstChild( "msg" ).setValue( "I am not your father" );
			throw new FaultException( "WrongMessage", faultMessage );
		}
		Value response = Value.create().getFirstChild( message );
		response.getFirstChild( "reply" ).setValue( "I am your father" );
		return response;
		
	}
	
	public void AsyncHelloWorld( Value request ) {
		String message = request.getFirstChild( "message" ).strValue();
		System.out.println( "async " + message );
		Value response = Value.create().getFirstChild( message );
		response.getFirstChild( "reply" ).setValue( "I am your father" );
		try {
			Thread.sleep( request.getFirstChild( "sleep" ).intValue() );
		} catch ( InterruptedException e ) {
			e.printStackTrace();
		}
		sendMessage( CommMessage.createRequest( "reply", "/", response ) );
	}
}
