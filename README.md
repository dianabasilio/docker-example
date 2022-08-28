# Docker

## Dockerfile
This allows to buil up the image from another image
To add a operating system in there
from image node ...
This image exists on docker hub
### FROM node

for setting the working directory of de docker container
everything will be relative to this working directory
### WORKDIR /app

To tell docker wich files should go into the image
 The first dot means that all files where docker file is will be copied into the image (Host file system)
 ./ (image container file system), this is the path inside of the image where those files should be store on dockeer
/app to not guess but to know
### COPY . /app

In this project we need to run npm install
to run a command on the image
###  RUN npm install

RUN node server.js -> (run project) this woul de incorrect because all this set up instructions are for the image
but the image is just template of the code

set the port just for DOCUMENTATION (could be removed) but for better practice add it.
### EXPOSE 80

The image is not run, the container is what is run

CMD does not run on the image but when a container is started based on the image
CMD command
### CMD ["node", "server.js"]

a Docker container is isolated from local environment so it has its own internal network

## Commands
On the terminal then run:
to create image based on a dockerfile:
` $docker build . `

to show all the images
` $docker images -a ` 

` $docker run <IMAGE ID> `

to see all the running ps
` $docker ps ` 

to see all the running and exited
` $docker ps-a ` 

To stop container
` $docker stop <CONTAINER NAME> `

 -p to publish under which port sould be accessible (CORRECT WAY TO RUN) (docker run creates a new container) attached container.
` $docker run -p 8000:80 <IMAGEID> `
To run it on detached mode:
` $docker run -p 8000:80 -d <IMAGEID> `
To attach it again:
` $docker attach <CONTAINER NAME> `

to not use layered base arch
` $docker build  --no-cache . `

to see all docker commands
` $docker --help `
` $docker ps --help `

To restart a container (not create a new one)
` $docker ps -a ` (to see all container)
` $docker start <CONTAINER NAME>` (to RESTART that container) detached container.
` $docker start -a <CONTAINER NAME>` (to RESTART that container) attached container.
` $docker start -a -i <CONTAINER NAME>` (to RESTART that container) attached container and interact with it (inputs).

To fetch the log on a container (To see all the console logs)
` $docker logs <CONTIANER NAME>`

To keep on listening the logs (attached container).
` $docker logs -f <CONTIANER NAME>`

To interact like use inputs in terminal
` $docker run -i <imageid>`

## Questions

### What are "Images" (when working with Docker)?
-Images are "blueprints" for containers wich then are running instances with read and write access.

### What does "Isolation" mean in the context of containers?
- Containers are separated from each other and have no shared data or state by default.

### What's a "Container"?
- A container is an isolated unit of software wich is based on an image. A running instance of that image.
- 
### What are "Layers" in the context of images?
- Every instruction in an image creates a cacheable layer -layers help with image re-building and sharing.

### What does this command do: docker build .? 
- It builds an image

### What does this command do: docker run node?
- It creates and runs a container based on the "node" image.