#Image creation
Image creation can be done in a host where Docker is installed.
From a shell opened in this folder run the following:

docker build -t hello .

hello is the name of the image.

#Run the container
docker run --name hello-cnt -p 8000:8000 hello
