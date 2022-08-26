#This allows to buil up the image from another image
#To add a operating system in there
#from image node ...
#This image exists on docker hub
FROM node

#for setting the working directory of de docker container
#everything will be relative to this working directory
WORKDIR /app

#To tell docker wich files should go into the image
# The first dot means that all files where docker file is will be copied into the image (Host file system)
# ./ (image container file system), this is the path inside of the image where those files should be store on dockeer
#/app to not guess but to know
COPY . /app

#In this project we need to run npm install
#to run a command on the image
RUN npm install

#RUN node server.js -> (run project) this woul de incorrect because all this set up instructions are for the image
#but the image is just template of the code

#set the port just for DOCUMENTATION (could be removed) but for better practice add it.
EXPOSE 80

#The image is not run, the container is what is run

#CMD does not run on the image but when a container is started based on the image
#CMD command
CMD ["node", "server.js"]
