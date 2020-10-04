FROM jolielang/jolie
MAINTAINER Claudio Guidi <guidiclaudio@gmail.com> 
EXPOSE 8000
RUN mkdir micro
WORKDIR micro
COPY TrafficService/trafficService.ol main.ol
COPY TrafficService/trafficInterface.iol trafficInterface.iol
CMD jolie main.ol