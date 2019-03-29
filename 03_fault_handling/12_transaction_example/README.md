# Buying transaction example

In this example we model a simplified version of an electronic purchase
where a transaction server governs all the transactions. This example helps in understanding
better how termination and compensation hadlers work.

Run the following commands in different shells:

* `jolie transaction_server.ol`: this is the service in charge to govern the transactions;
* `jolie product_store.ol`: this is the service in charge to manage the product store;
* `jolie logistics.ol`: this is the service in charge to manage product delivering;
* `jolie bank_account.ol AMOUNT`: this is the service in charge to manage the bank accounts. AMOUNT is the initial amount of the sample credit card used in this example (default:1000);
* `jolie client.ol`: this is the user script which tries to buy 10 beers.

Try twice:
* try the first by setting the AMOUNT to 10000: the purchase will have success;
* try the second time by setting AMOUNT to 1: the purchase will fail because of insufficient amount.
Some activities on the transaction service will be rolled back.
