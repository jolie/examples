FROM jolielang/jolie
MAINTAINER Claudio Guidi <guidiclaudio@gmail.com> 
EXPOSE 8000
RUN mkdir micro
WORKDIR micro
COPY InfoService/infoService.ol main.ol
RUN mkdir interfaces
COPY InfoService/interfaces/trafficInterface.iol interfaces/trafficInterface.iol
COPY InfoService/interfaces/infoInterface.iol interfaces/infoInterface.iol
COPY InfoService/interfaces/forecastInterface.iol interfaces/forecastInterface.iol
CMD jolie --trace main.ol
