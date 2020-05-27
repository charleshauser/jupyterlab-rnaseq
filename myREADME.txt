# jupyterlab_star-vice
jupyterlab vice image with snakemake-minmal

DOCKERHUB_USERNAME=chauser
docker build -t $DOCKERHUB_USERNAME/jupyterlab-scipy:cyverse .
docker run --rm -it -v ~/data:/data -p 8888:8888 $DOCKERHUB_USERNAME/jupyterlab-scipy:cyverse


docker run --rm -it -v ~/data:/home/work/data -p 8888:8888 $DOCKERHUB_USERNAME/jupyterlab-scipy:cyverse


Next steps would be
- create an image, 
push the image to a public repo, 
create a new tool and build an app using this tool. 

Steps to create a tool and an app for VICE are documented here 
https://learning.cyverse.org/projects/foss-2020/en/latest/CyVerse/vice.html. 

This tutorial uses rstudio as an example. Jupyterlab vice app can also be creating using same steps. You only have to change the port number for jupyterlab- which is 8888. I'm happy to help if you are stuck at any step. Let me know. Best, Reetu

--

Reetu	Reetu from CyVerse



docker build -t $DOCKERHUB_USERNAME/jupyterlab-scipy:star .
docker run --rm -it  -p 8888:8888 $DOCKERHUB_USERNAME/jupyterlab-scipy:star


# run and link to ~/data/
docker run --rm -it -v ~/data:/home/jovan/data -p 8888:8888 $DOCKERHUB_USERNAME/jupyterlab-scipy:star

#push to Docker
 docker push  chauser/jupyterlab-scipy-star




/home/jovyan
