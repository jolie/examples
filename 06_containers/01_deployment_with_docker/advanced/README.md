#Image creation
From a shell opened in this folder run the following:

docker build -t hello_plus .

hello is the name of the image.

#Get the IP of the container hello-cnt you want to connect with
docker inspect --format '{{ .NetworkSettings.IPAddress }}' hello-cnt

Let us suppose it is: 172.17.0.4

#Run the container
dockerun --name hello-plus-cnt -p 8001:8001 -e JDEP_HELLO_LOCATION="socket://172.17.0.4:8000" -e JDEP_CUSTOM_MESSAGE=" :plus!" hello_plus
