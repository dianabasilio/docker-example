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

### RUN npm install

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
`$docker start <CONTAINER NAME>` (to RESTART that container) detached container.
`$docker start -a <CONTAINER NAME>` (to RESTART that container) attached container.
`$docker start -a -i <CONTAINER NAME>` (to RESTART that container) attached container and interact with it (inputs).

To fetch the log on a container (To see all the console logs)
`$docker logs <CONTIANER NAME>`

To keep on listening the logs (attached container).
`$docker logs -f <CONTIANER NAME>`

To interact like use inputs in terminal.
`$docker run -i <imageid>`

To remove containers (they must be stopped), we can remove several at the same time.
`$docker rm <CONTIANER NAME> <CONTIANER NAME> <CONTIANER NAME>`

To list all images.
`$docker images`

To remove images (that ARE NOT BEING USED by a container (running or stopped)), we can remove several at the same time.
`$docker rmi <IMAGEID> <IMAGEID> <IMAGEID>`

To remove ALL images that are not being used.
`$docker image prune`
To remove ALL images that are not being used even if they have a tag.
`$docker image prune -a`

To automatically remove the container when it exits (stop). flag --rm, flag -d (dettached)
` $docker run -p 8000:80 -d --rm <IMAGEID> `
To do the same but with a name
` $docker run -p 8000:80 -d --name <appname> --rm <IMAGEID> `

To inspect image. To know all about that image, when was it created, the configurations like ports or variables, docker version, operating system.
` $docker image inspect <IMAGEID> `

To copy a file into a container.
`$docker cp <foldername>/test.txt <container name>:/<container path(you choose)>`

Or to copy everything inside a folder.
`$docker cp <foldername>/. <container name>:/<container path(you choose)>`

Or to copy from cotainer to local.
`$docker cp <container name>:/<container path(you choose)> <foldername>`

To name a container
`docker run -p 3004:80 -d --rm --name <NAME> <CONTAINERID>`

To name an image -> name: tag --> example node : 14
tag:version
name: appname
`docker build -t <NAME>:<TAG> .`
`docker run -p 3004:80 -d --rm --name <NAME> <NAME>:<TAG>`


To rename an image (clone)
`docker tag <NAME>:<TAG> <NEW-NAME>:<NEW-TAG>`

## Questions

### What are "Images" (when working with Docker)?

-Images are "blueprints" for containers wich then are running instances with read and write access.

### What does "Isolation" mean in the context of containers?

- Containers are separated from each other and have no shared data or state by default.

### What's a "Container"?

- A container is an isolated unit of software wich is based on an image. A running instance of that image.

### What are "Layers" in the context of images?

- Every instruction in an image creates a cacheable layer -layers help with image re-building and sharing.

### What does this command do: docker build .?

- It builds an image

### What does this command do: docker run node?

- It creates and runs a container based on the "node" image.


## Share docker

When we share just the dockerfile, we need to also share the code. 

So we need to share it via dockerhub or Private registry. 

### Private Registry
There are a lot of providers for private registry, you can also use this.

### dockerhub
It has a free plan. Official Docker Image Registry.
`docker push <IMAGENAME>`
`docker pull <IMAGENAME>`

Create a dockerhub account, create a repository (image)

![image](https://user-images.githubusercontent.com/81311646/188522888-2a032eee-5d22-4155-a7d7-7c3e5b2d721f.png)
Here dianabasilio/react-app is the image name

You need to stablish a conection with this command to login:
`docker login`

You need to use the same image name that is in the repository.
`docker push <image-name>`

You call also pull this image even if you are logged out.
`docker pull <image-name>`

To run this pulled image just use any of these commands, this works even if you haven't pulled the image just check you do not have it locally so you have
the latest version.
`docker run <image-name>`
`docker run -p 8000:3000 <image-name>`

## Volumes

Volumes are folders on your host machine hard drive wich are mounted ("made available", mapped) into containers.
A volume persists if a container shuts down. If a container (re-)starts and mounts a volume, any data inside of that volume is avaible in the container.
A container can write data into a volume and read data from it.

### What is a Volume?
- A folder/file inside of a Docker container wich is connected to some folder outside the container.
- Volumes are managed by Docker, you don´t necessarily know where the host folder (wich is mapped to a container path) is.

To create volumes
`docker volume create <volumeName>`

To inspect volumes
`docker volume inspect <volumeName>`

To remove volume (that is not in use by a container) you need to stop that container. ALL DATA IS LOST
`docker volume rm <volumeName>`

### we have 2 types of volumes

#### Anonymous
This only exists if the container exists.
Created specifically for a single container.
Survives container shutdown/restart unless --rm is used.
Can not be shared across containers.
- Useful when you can use them to prioritize container-internal paths higher than external paths.

- They can be created directly on dockerfile
example:
VOLUME ["/app/feedback"]

- or they can be created with run -v /app/blabla

#### Named Volumes
Volumes will survive even if container removed.
- Created in general, it is not tied to any specific container.
- Can be shared across containers.

To list all volumes
`docker volume ls`

flag -v <name>:<path>
`docker run -p 3007:80 -d --rm --name feedback-app -v feedback:/app/feedback feedback-node:volumes`

### to delete volumes

`docker volume rm <VOL_NAME>`

## Bind Mount (uses absolute path)

Are similar to volumes, but volumes are managed by docker and we do not know where the host is, with bind mount you know, you define a folder/path on your host machine.
It is great for persistent, editable (by you) data.

With bind mount we can change something locally and it updates the container with to need to create another container.

- They are not tied to specific container.
- They survive to rm container.
- Can be shared across containers.
- Can be re-used for same containers.
- Useful when you want to provide "live data" to the container (no rebuilding needed).
- They are write read by default. To ensure container only reads write :ro at the end

Add the complete route to your project, (double -v)

`docker run -p 3007:80 --name >name> -v feedback:/app/feedback -v "<completeroute>:/app/feedback"  feedback-node:volumes`

- Path shortcuts
macOS / Linux: -v $(pwd):/app

Windows: -v "%cd%":/app

Sometimes node module is not there
`docker run -p 3007:80 --name >name> -v feedback:/app/feedback -v "<completeroute>:/app/feedback" -v /app/node_modules feedback-node:volumes`

We can add to avoid some errors on node js apps with bind mount:

`"devDependencies": {"nodemon":"2.0.4"}`

### What is a Bind Mount?
- A path on your host machine, wich you know and specified, that is mapped to some container-internal path.

