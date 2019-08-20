# Dockerization of a system of services
As a first step, create the images of the three microservices:
- `docker build -t forecast_img -f DockerfileForecastService .`
- `docker build -t traffic_img -f DockerfileTrafficService .`
- `docker build -t info_img -f DockerfileInfoService .`

Then create a network where the services will operate:
```
docker network create testnet
```

Finally, creates the three containers:
- `docker run -it -d --name forecast --network testnet forecast_img`
- `docker run -it -d --name traffic --network testnet traffic_img`
- `docker run -it -d --name info -p 8002:8000 -v <PATH TO config.ini>:/var/temp --network testnet info_img`

Note that the container `info` which executes the orchestrator requires a file `config.ini` to be run. In order to pass such a file it is necessary to set a volume for the container which maps the host directory where the config.ini file is, to the internal container directory `/var/temp`.

Then run the `client.ol` with a city name as a parameter.
try with Rome, Cesena or what you want
