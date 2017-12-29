/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.jolie.example.dynamicembedding;

import jolie.runtime.JavaService;
import jolie.runtime.Value;

/**
 *
 * @author claudio
 */
public class DynamicJavaService extends JavaService { 
	private int counter; 

	public Value start( Value request ) { 
		counter++; 
		Value v = Value.create(); 
		v.setValue( counter ); return v; 
	}
}