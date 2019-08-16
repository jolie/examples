include "ForecastInterface.iol"

outputPort Forecast {
Location: "socket://localhost:8000"
Protocol: sodep
Interfaces: ForecastInterface
}

main {
    nullProcess
}