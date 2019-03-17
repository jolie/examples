# Temperature Average Example
*temperature_collector.ol* is in charge to collect the temperature of all the sensors. Each sensor is simulated by service *temperature_sensor.ol*. At init, a sensor register itself to the temperature collector.

## Running the architecture
First of all run the temperature collector with the following command:

`jolie temperature_collector.ol`

Then you can run different sensors in different shells with the following command:

`jolie -C TemperatureSensorLocation=\"socket://localhost:10000\" temperature_sensor.ol`

where `socket://localhost:10000` is the listening location for the given sensor, thus pay attention to change the port number for each sensor.

If you want to simulate a bunch of sensors in a single command you can run:

c

where *NUM* is the number of sensors.

## Running the client
In order to retrieve the average temperature of the sensors, just run the client with the following command:

`jolie client.ol`
