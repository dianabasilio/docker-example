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
`$docker build .`

to show all the images
`$docker images -a`

`$docker run <IMAGE ID>`

to see all the running ps
`$docker ps`

to see all the running and exited
`$docker ps-a`

To stop container
`$docker stop <CONTAINER NAME>`

-p to publish under which port sould be accessible (CORRECT WAY TO RUN) (docker run creates a new container) attached container.
`$docker run -p 8000:80 <IMAGEID>`
To run it on detached mode:
`$docker run -p 8000:80 -d <IMAGEID>`
To attach it again:
`$docker attach <CONTAINER NAME>`

to not use layered base arch
`$docker build --no-cache .`

to see all docker commands
`$docker --help`
`$docker ps --help`

To restart a container (not create a new one)
`$docker ps -a` (to see all container)
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
`$docker run -p 8000:80 -d --rm <IMAGEID>`
To do the same but with a name
`$docker run -p 8000:80 -d --name <appname> --rm <IMAGEID>`

To inspect image. To know all about that image, when was it created, the configurations like ports or variables, docker version, operating system.
`$docker image inspect <IMAGEID>`

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
- REMEMBER to add volumes on dockercompose at the end.

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

`docker run -p 3007:80 --name >name> -v feedback:/app/feedback -v "<completeroute>:/app/feedback" feedback-node:volumes`

- Path shortcuts
  macOS / Linux: -v $(pwd):/app

Windows: -v "%cd%":/app

Sometimes node module is not there
`docker run -p 3007:80 --name <name> -v feedback:/app/feedback -v "<completeroute>:/app/feedback" -v /app/node_modules feedback-node:volumes`

We can add to avoid some errors on node js apps with bind mount:

`"devDependencies": {"nodemon":"2.0.4"}`

### What is a Bind Mount?

- A path on your host machine, wich you know and specified, that is mapped to some container-internal path.

## ARGuments & ENVironment variables

### ARG

- Available inside of dockerfile, NOT accessible in CMD or any application code.
- Set on image build (docker build) via --build-arg.

### ENV

- Available inside of Dockerfile & in application code.
- Set via ENV in Dockerfile or via --env on docker run
- for example declaring variable port on dockerfile:
  `ENV PORT 80`

- You can access port variable while running container and change its value.
- Changing port variable to 8000 (change algo de the publish port):
  `docker run -p 3007:8000 --name <name> --env PORT=8000`

- You can also do this with the .env file:
- On .env file write: PORT = 8000
  `docker run -p 3007:8000 --name <name> --env-file ./.env`

### Build Arguments

You can access Build arguments with --build-arg

On dockerfile: ARG <variable-name> = 80
`docker build -t <NAME>:<TAG> --build-arg <VARIABLE_NAME> = <value> .`

## Summary data and working with volumes.

Containers can read + write data.

- **Volumes** can help with data storage.
- **Bind Mounts** can help with direct container interaction.
- **Containers** can read + write data, but written data is lost if the container is removed.
- **Valumes** are folders on the host machine managed by docker. Wich are mounted into the container.
- **Named volumes** survive container removal and can therefore be used to store persistent data.
- **Anonymous volumes** are attached to a container. They can be used to save temporary data inside the container.
- **Bind Mounts** are folders on the host machine wich are specified by the user and mounted into containers like named volumes.
- **Buil ARGuments and runtime ENVironment variables** can be used to make images and containers more **dynamic/Configurable**.

## Networking: (cross-) Container communication

### 3 types of communication:

- Container to www
- Container to localhost
- Container to container

## Container to www

This communication has no problem, we do not need anything else.

## Container to localhost

You need to change `localhost` to `host.docker.internal`

## Container to Container

First inspect the other container:
`docker container inspect <container-name>`

Copy the IPAddress
You need to change `localhost` to `IPAddress`

### Docker Networks (Elegant Container to Container)

Within a Docker network, all containers can communicate with each other and IPs are automatically resolved.

`docker run --network my_network ...`

1. Stop and remove the containers you want to connect.
2. To create a new docker network: `docker network create <network-name>`.
3. To inspect networks created: `docker network ls`.
4. With that you can run `docker run --name <name-1> --network <network-name> <image>`
5. NOTE: we did not publish the ports on the last command
6. You need to change `localhost` to `<container-name>`.
7. Do the same last steps with the other container you wanna connect to this one.

## Check this multicontainer repo

### https://github.com/dianabasilio/multi-container-docker

## DOCKER COMPOSE

Used to automate multi-Container Setups.
One configuration file + Orchestration commands (build, start, stop).

- Docker Compose does not replace Dockerfiles for custom Images.
- Docker Compose does NOT replace Images or Containers.
- Docker Compose is NOT suited for managing multiple containers on different hosts (machines).
- Here services are containers. -> define port, volumes, environment, networks.
- You need to create a yml file

By default you do NOT need to specify --rm flag or -d flag on docker compose, networks is not needed

Create docker-compose.yml

Run `docker image prune -a`
Run `docker container prune`
Run `docker-compose up` (attached) or `docker-compose up -d` (dettached)
To delete and stop all containers `docker-compose down`
If you want to also delete the volumes run `docker-compose down -v`
To see more options `docker-compose --help`
With --build flag you force that docker re build the image (if any changes) `docker-compose up --build`
To only build image and NOT run containers with compose just `docker-compose build`

### summary docker compose

- With docker-compose you can define volumes and add them to containers.
- With docker-compose, a default network for all composed containers is created.
- docker-compose and docker commands can work together.
- Docker compose mainly solves annoying repetition of (long) commands.

## other docker commands

- run `docker exec <command>` to run extra commands that are not inside the dockerfile.

## Building a first utility container

- workdir /app (dockerfile)
- docker build -t node-util .

### using bind mount, and here you will run npm init

- docker run -it -v C:\Users\dbasilio\OneDrive-deacero.com\Documentos\basic\learning-docker\nodejs-app-starting-setup\nodejs-app-starting-setup:/app node-util npm init

### using bind mount, and here you will run npm install

- docker run -it -v C:\Users\dbasilio\OneDrive-deacero.com\Documentos\basic\learning-docker\nodejs-app-starting-setup\nodejs-app-starting-setup:/app node-util npm install

### to restrict the commands that you can run use ENTRYPOINT:

- With this now you can pass command on run and they will be appended, this can not be done with cmd.
- ENTRYPOINT ["npm"] (Dockerfile) (build image again)

### with that now you do not need the word npm on the command

- docker run -it -v C:\Users\dbasilio\OneDrive-deacero.com\Documentos\basic\learning-docker\nodejs-app-starting-setup\nodejs-app-starting-setup:/app node-util init (this will add package json on the project locally because of bind mount)

### now with DOCKER COMPOSE

- docker-compose exec (to run commands on already running containers)
- docker-compose run npm run init (to run depending on the service name)
- docker-compose run --rm npm run init (so that container would be removed when end)

## Section 9: Deploying Dcoker Containers.

### To take in count

- Bind Mounts shouldn´t be used in Production.
- Containerized apps might need a build step (like React apps).
- Multi-Container projects might need to be split (or should be split) across multiple host/remote machines.
- Trade-offs between control and responsability might be worth it.

### Hosting providers (Cloud services)

- AWS- Amazon Web Services.
- Azure- Microsoft Azure.
- Google Cloud.
- There are more....

# DOCKER WITH PHP LARAVEL

## Adding a Nginx (web server container)

You should read the docs

### Add docker compose yml

version: "3.8"
services:

## Adding php container:

### https://hub.docker.com/_/php How to install more PHP extensions

RUN docker-php-ext-install pdo pdo_mysql

:delegated (optimización) se procesa en baches (loltes) improve performance.

### AWS

AWS-EC2: It is a service that allows you to spin up and manage your own computers/remote machines on the cloud.

#### STEPS to use EC2

1. Create and launch EC2 instance, VPC and security group.
2. Configure security group to expose all required ports to WWW.
3. Connect to instance (SSH) (to connect to the remote machine), install Docker and run container.

### In Production

- A container should really work standalone, you should NOT have source code on your remote machine.
- Instead of using bind mounts, we use COPY.
- Remember that bind mount are declared with -v flag (on run command) or in docker-compose. NOT dockerfile.

## Kubernetes

- Is an open-source system for automating deployment, scaling, and management of containerized applications.

### before kubernetes we had a problem

- We used to create everuthing manually, we created the instance ec2, and deploy push/pull manually, it is hard to maintain, error-prone and annoying.
- Containers might crash/go down and need to be replaced.
- Aws help us to check container health and automatic re-deployment.
- We might need more container instances upon traffic spikes.
- AWS help us Autoscaling.
- Incoming traffic should be distributed equally.
- AWS give us load balancer that give us a domain, and split equally incoming traffic.

### Using a specific cloud service lock us into that service

- Of course you might be fine with sticking to one provider though!
- You need to learn about the specifics, services and config options of another provider if yu want to switch.

### Kubernetes

- An open-source system (and de-facto standard) for orchestrating container deploymnets.
- It is like a docker-compose for multiple machines.
- It help us with: automatic deployment, scaling and load balancing, management.
- It could be used on any provider.
- Provides an standardized way of describing the to-be and to-be managed resoucers of th kubernetes cluster. Cloud-provider-specific settings can be added.

#### What kuberneter is NOT

- It is not a cloud service provider.
- It is not a service by a cloud service provider.
- It is not just a software you run on some mahcine.
- It is not an alternative to docker.
- It is not a paid service.

#### What kuberneter is

- It is an open source project that can be used with any cloud provider.
- It can be used with any provider.
- It is a collection of concepts and tools.
- It works with docker containers.
- It is a free open-source project.

### Pod, proxy and worker node on kubernetes.

- The pod has a container inside. and a pod is inside a worker node (your virtual machines, instance).
- Proxy is also inside a worker node to control the network traffic.
- You will need probably different worker nodes.
- Multiple pods can be created and removed to scale your app.
- Tha master node controls and interacts the node to control them it has the control plane. Controls your deployment. It send the instructions to the cloud provider API.

### What you need to do/ setup

- Create the cluster and the node instances (worker+Master nodes)
- Setup API server, kubelet and other kuberneter services / software on nodes.
- Create other (cloud) provider resources that might be needed (load balancer filesytems).

### What kuberneted will do

- Create your objects (pods) and manage them.
- Monitor pods and re-create them, scale pods.
- Kubernetes utilizes the provided cloud resources to apply your configuration/goals.

### Worker node

- Think of it as one computer /machine/virtual instance.
- Is managed by the master node.
- Inside worker nodes are pods: hosts one or more application containers and their resources.
- Pod are created and managed by kubernetes. Inside pods there are containers and volumes.
- Docker is also inside worker node.
- Kubelet is also inside worker node: communication between master and worker node.
- Kube-proxy: Managed node and pod communication.

### Core components Kubernetes

- Cluster: a set of node machines wich are running the containerized application ( workernodes) or control other Nodes (master node).
- Nodes: Physicar or virtual machine with a certain hardware capacity which hosts one or multiple pods and communicates with the cluster.
- Master node: Cluster control plane, managing the pods across worker nodes.
- Worker Node: Hosts pods, running app containers (+resources)
- Pods: Pods hold the actual running app containers + their required resources (volumes)
- Container: Normal docker containers.
- Services: Are logical set (group) of Pods with a unique, por-and-container- independent ip address.

## Kubernetes questions

- Kubernetes helps with: deployment of (more complex) containerized applications.
- Cluster: a network of machines wich are split up in worker and master nodes.
- Worker node: a machine which hosts running pods/containers.
- Pods: a "shell" for container -responsible for running and containing that container(+any other required config and volumes)

## Kubernetes works with objects:

- Pods: the smallest "unit" kubernetes interacts with. They run 1 or multiple containers, typically just one."one container per Pod".Pods contain shared resources (volumes) for all Pods containers. a Pos has a cluster-internal IP by default.Containers inside Pods communicate with each other via localhost. Pods are designed to be ephemeral: kubernetes will start, stop and replace them as needed.
- Deployment: The "deployment" object is important. Controls (multiple) Pods.You set a desired state, kubernetes then changes the actual state.Define wich pods and containers to run and the number of instances.Deployments can be paused, deleted and rolled back.Deployments can be scaled dynamically (and automatically)
- services
- volumes

## kubernetes commands

- To see everything is up and running:
- `$ minikube status`

- To send an image to that cluster: to send instructions to the kubernetes cluster (kubectl)
- `$ kubectl help`

- To see what you can create (objects)
- `$ kubectl create`

### imperative way to create objects

- To create a deployment object and automatically send it to the kubernetes cluster
- `$ kubectl create deployment`

- To see all "" objects
- `$ kubectl get deployments`
- `$ kubectl get pods`

- To delete objects
- `$ kubectl delete my-app-name deployment`

### To deploy with kubernetes

- Create a local image with docker.
- Push that image into dockerhub
- `$ kubectl create deployment my-app-name --image=remote-image-name`
- $ kubectl get deployments, you should see: 1/1 ready.
- $ kubectl get pods, you should see: 1/1 ready and status running.
- $ minikube dashboard, it should open the dashboard on other page.

### To have multiple pods (replicas)

- This is used when you need to have more pods in case you application terminates.
- `$ kubectl scale deployment/first-app --replicas=3`
- To see all the pods you should see 3 pods:
- $ kublect get pods

### updating deployments

- This is used for when you update your code.
- First build a new image with a new tag :2:
- $ docker build -t academind/first-app:2 .
  -$docker push ...
- Now update deployment, you equal the last image to the new image.
- $kublect set image deployment/first-app kub-first-app=academind/first-app:2.

- $kublect rollout undo deployment/first-app
- $ kublect rollout status deployment/first-app
  To go to a specific version
- $kublect rollout undo deployment/first-app --to-revision=1

## Imperative vs declarative kubernetes usages.

### Imperative

- Individual commands are executed to trigger certain kubernetes actions.
- $kublect create deployment
- Comparable to using docker run ...

### Declarative

- $ kublect apply -f config.yaml
- a config file is defined and applied to change the desired state.
- Comparable to using docker compose.

#### each object needs a metadata

- After config the deployment.yaml
- $ kubectl apply -f=deployment.yaml

### livenessProbe

- Where you define how kubernetes should verified if the container is up and running.

## Summary module 12

### What kubernetes will do

- Create your objects (e.g. Pods) and manage them.
- Monitor Pods and re-crete them, scale Pods etc.
- Kubernetes utilizes the provided (cloud) resources to apply your configuration/goals.

### What you need to do / Setup

- Create the cluster and the Node instances (Worker + Master Nodes).
- Setup API Server, kubelet and other Kubernetes services / software and Nodes.
- Create other (cloud) provider resources that might be needed (load balancer, Filesystems).

### Kubectl

- A tool for sending instructions to the cluster.

### Cluster

- Contains the master node and the worker node

### Kubernetes objects

- Kubernetes works with Objects.
- Objects are: Pods, Deployments, Services, Volumes ..
- Objects can be created in two ways:

- Imperatively or Declaratively.

### Imperatively

- `$ kubectl create deployment first-app --image=academicind/kub-first-app`

- To create a service like a load balancer:
- `$ kubectl expose deploymeny first-app --port=8080 --type=LoadBalancer`

### Declaratively

- here you write your deployment and service yamls and apply them by using this command:
- `$ kubectl apply -f=deployment.yaml -f=service.yaml`
- you can delete resources by
- `$ kubectl delete -f=deployment.yaml`

### You can user deployment.yaml and service.yaml on a same file.

- "Nodes" are your machines/virtual instances, inside cluster.
- Worker Nodes tun the containers of your application.
- "Master Node" controls your deployment (all worker nodes), inside cluster.

## Module 13 managing data and volumes with kubernetes

### State

- State is data created and used by your application wich must not be lost.
- Could be User-generated data, user accounts, (stored in a database).
- Intermediate results derived by the app.

- Kubernetes needs to be configured to add Volumes to our containers.

### Volumes

- Kubernetes can mount Volumes into containers.
- Volume lifetime depends ont he pod lifetime.
- Volumes are removed when Pods are destroyed.
- Volumes on kubernetes are not as easy to maintain as in Docker.
- the type of volume depends here now in the type of driver.

#### First volume "emptyDir"

- empty dir is a type of volume, creates a new emptydirectery and keeps it alive when pod is alive, when a pod is remove this directery is removed, and when it creates another pod this is created again.
- on deployment.yaml on the spec of the container (pod), we will add:
- volumes:
- -name: story-blabla
- emptyDir: {}

- Add volumeMounts: mountPath:

- This is a great basic volume, but what it we have 2 different replicas? it FAILS. the traffic got redirected to the other pod.

#### second volume hostPath driver

- Multiple pods can have the same hostPath for volumes. hostPath will share a path with each pod you want.
- This only works locally.

### understanding the CSI volume type.

- The other types are very specific, like aws.
- CSI, was built to be used for any cloud, anyone can use this interface, if you want to use amazon elastic file system you can use this with nfs type, but might take an extra work.
- Thanks to thi CSI feature will be super easy to use, is very flexible type. We do not really need this for locally, but for cloud we need CSI to store out data.

### CSI, hostPath and emptyDir, volumes are destroyed when a pod is removed.

- With minikube we only have 1 worker node, but when you move from local to a real deployement for example aws, you will have multiple nodes and hostpath also won´t help you. Multiple pods might not share same data.

- Pod and Node-independent Volumes are sometimes required.
  so we have....

## Persistent volumes

- They will be "ouside" the nodes.
- They are independent from the node.
- To create a persistent volume, you can create a yaml host-pv.yaml
- kind: PersistentVolume
- Add the same path as development.yaml
- You need to specify the storage: 4Gi
- accessMode: (there are 3 possible access, ReadWriteOnce : same node (hostpath need this), ReadOnlyMany: multiple pods can use this volume, ReadWriteMany: )

Create host-pvc.yaml

- On deployment.yaml
- persistentVolumeClaim:
- claimName: host-pvc

## storage class on kubectl

- $kubectl get sc
- There is a storage class included, it is a concept to give admins control about volume configure, how exactly that storage should be provison, provide important information to volume config, you just need to make sure you are using this. on host-pv.yaml

- to use that simple add storageClassName: standard on host-pv.yaml and host-pvc.yaml

- `$ kublect apply -f=host-pv.yaml`
- `$ kublect apply -f=host-pvc.yaml`
- `$ kublect apply -f=deployment.yaml`

# To get all the persistent volumes

- `$ kubectl get pv`

# To get all the claims, you need claim to counter part to persistent valume, how much space it needs, sets as a volume claim, you specify the volume and the host pv

- `$ kubectl get pvc`

## Main difference pv (persistent volume) and pvc (persistent volume claim) is that the persistent volume I think is the data perse (path) and the persistent volume claim is the configuration that is use to pass it to the deployment

### Normal volumes vs persistent volumes

- Both will allow you to persist data and data should not be lost when a container is restart, deleted or removed.
- The "normal" volumes are independent from the container but not independent from the pod, they are attached to the pod and their life cycle, if the pod is reacreated it will depend on the volume type, for example the empty dir part will then start again empty if the pod is reacreated vs host type or other cloud provider types will NOT lose data.
- The BIG PROBLEM with "normal" volumes is that it is repetitive and hard to administrate on a global level. This might be annoying when you have multiple pods. Persistent volumes solve that problem.
- In the "normal" volumes we define the config on the pod vs persistent volumes that is defined "outside".

#### On persistent volumes

- Volume is a standalone cluster resource (not attached to the pod).
- Created standalone, claimed via PVC.
- Can be defined just once and be used multiple times.

## Env variables on kubernetes are on the deployment.yaml inside spec: as env: with a name: and a value:

## OR

## you can also set env variables on environment.yaml (so that this config can be used on multiple pods)

- kind: ConfigMap
- $ kublect apply -f=environment.yaml
- $ kublect get configmap

- On deployment you should add valuefrom: ConfigMapKeyRef: name:
