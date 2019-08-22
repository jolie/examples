# Using Jocker for dockerizing a system of Jolie services
In this example we exploit [Jocker](https://github.com/jolie/jocker) for managing container on Docker.
In particular here we show how to orchestrate docker using Jocker for deploying a system of three Jolie services:
As a first step, create the images of the three microservices:
- ForecastService
- TrafficService
- InfoService: it is an orchestrator which collects information from both the TrafficService and the ForecastService

Before running the orchestrator which is in charge to deploy the system into Docker, download and run the Jocker container using the following commands:

```
docker pull jolielang/jocker
docker run -it -p 8008:8008 --name jocker -v /var/run:/var/run jolielang/jocker
```

Once Jocker is running, just execute the Jolie orchestrator for deploying the system:

```
jolie jockerOrchestrator.ol
```

Note that the orchesstrator creates, uses and destroys the system thus at the end of the execution there will not be contaneiners and images registered inside the docker server.