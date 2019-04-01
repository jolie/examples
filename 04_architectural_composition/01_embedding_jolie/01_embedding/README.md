# Embedding a Jolie Service

This simple example shows how embedding primitive works. The service _clean_div.ol_ clean a message from tags _div_ and _br_. 
It embeds another service called _clean_br.ol_ which is responsible for cleaning just the tags _br_. Since the latter service 
is embedded it is sufficient to run the former for executing the complete architecture:

`jolie clean_div.ol`

Run the client in anotehr shell for seeing the results:

`jolie client.ol`
