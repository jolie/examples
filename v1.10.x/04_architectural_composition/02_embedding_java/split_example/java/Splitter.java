package example;

import jolie.runtime.JavaService;
import jolie.runtime.Value;

public class Splitter extends JavaService {

  /* the method receives a Value message as a request and replies with a Value */
	public Value split( Value s_msg ){
		/* here we read the subnode of the request message */
		String string = s_msg.getFirstChild("string").strValue();
		String regExpr = s_msg.getFirstChild("regExpr").strValue();

		String[] sa = string.split( regExpr );

		/* here we prepare the reply message */
		Value s_res = Value.create();
		int i = 0;

		/* here we prepare the subnode 's_chunk' as an array of strings */
		for( String s : sa ){
			s_res.getNewChild( "s_chunk" ).setValue( s );
		}

		return s_res;
	}
}
