#This allows to buil up the image from another image
#To add a operating system in there
#from image node ...
#This image exists on docker hub
FROM node:14

#SETTING A DEFAULT PORT (this is dynamic)
ARG DEFAULT_PORT = 80

#for setting the working directory of de docker container
#everything will be relative to this working directory
WORKDIR /app

#This copy package json to ensure npm install only runs when package.json is changed
COPY package.json /app

#In this project we need to run npm install
#to run a command on the image
RUN npm install

#To tell docker wich files should go into the image
COPY . .

#Using environment variables
ENV PORT $DEFAULT_PORT

#RUN node server.js -> (run project) this woul de incorrect because all this set up instructions are for the image
#but the image is just template of the code

#set the port just for DOCUMENTATION (could be removed) but for better practice add it. 
#here port is 80
EXPOSE $PORT

#The image is not run, the container is what is run

#CMD does not run on the image but when a container is started based on the image
#CMD command
CMD ["node", "server.js"]
