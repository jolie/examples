FROM jolielang/jolie
MAINTAINER Claudio Guidi <guidiclaudio@gmail.com> 
EXPOSE 8000
RUN mkdir micro
WORKDIR micro
COPY ForecastService/forecastInterface.iol forecastInterface.iol
COPY ForecastService/forecastService.ol main.ol
CMD jolie main.ol
