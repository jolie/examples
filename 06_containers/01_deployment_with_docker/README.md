# Image creation

Make sure you have Docker installed.

From a shell opened in this folder, run the following:

```docker build -t hello .```

This creates a docker image called `hello` is the name of the image.

# Run the container

```
docker run --name hello-cnt -p 8000:8000 hello
```
