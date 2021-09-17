This example requires jolie > v1.10.x

![](https://docs.jolie-lang.org/v1.10.x/.gitbook/assets/arch_parallel_example.png)

In this example service `infoService` compose in parallel thw two calls towards `trafficService` and `forecastService`.

Run the following services into different consoles:
- infoService.ol
- trafficService.ol
- forecastService.ol

Then run the client.ol with a city name as a parameter.
try with Rome, Cesena or what you want
