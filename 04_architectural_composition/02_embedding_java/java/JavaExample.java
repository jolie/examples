package example;

import jolie.runtime.JavaService;
import jolie.net.CommMessage;
import jolie.runtime.Value;
import jolie.runtime.ValueVector;

public class JavaExample extends JavaService {

 /* here we receive a request from operation start, the request is void => there are no parameters  */
 public void start(){
		String s_string = "a_steaming_coffee_cup";
		String s_regExpr = "_";

		/* s_req is the variable which contains the reply, it is of type Value which is
		the Java representation of a Jolie tree variable. getNewChildm ìì, getFirstChild, getChildren, etc..
		are some of the methods you can use for navigating into the tree value in Java */
		Value s_req = Value.create();
		s_req.getNewChild("string").setValue(s_string);
		s_req.getNewChild("regExpr").setValue(s_regExpr);
		/* the response has now two subnodes 'string' and 'regExpr' which correspond to the
		expected message type Split_req of the parent jolie service */

		try {
			System.out.println("Sent request");
			/* here we create a message for the operation split of the parent jolie service */
			CommMessage request = CommMessage.createRequest( "split", "/", s_req );
			/* here we concretely send the message to the parent service */
			CommMessage response = sendMessage( request ).recvResponseFor( request );
			System.out.println("Received response");

			/* here we just print out the response */
			Value s_array = response.value();
			ValueVector s_children = s_array.getChildren("s_chunk");
			for( int i = 0; i < s_children.size(); i++ ){
				System.out.println("\ts_chunk["+ i +"]: " + s_children.get(i).strValue() );
			}

		} catch( Exception e ){
			e.printStackTrace();
		}
	}
}
