This example requires jolie > v1.10.x

![](https://docs.jolie-lang.org/v1.10.x/.gitbook/assets/arch_parallel_example.png)

In this example service `infoService` composes in parallel thw two calls towards `trafficService` and `forecastService`.
Service `forecastService` uses an input choice for offering two operations: `getTemperature` and `getWind`.

run the following services into different consoles:
- infoService.ol
- trafficService.ol
- forecastService.ol

then run the client.ol with a city name as a parameter.
try with Rome, Cesena or what you want.


