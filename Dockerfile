FROM continuumio/anaconda3

# based on continuumio/anaconda3
# docker build -t samisaf/pyre:latest .
# docker run --rm -ti samisaf/pyre:latest
# docker push samisaf/pyre:latest

# Add R kernel to jupyter notebook
RUN apt-get install -y libzmq3-dev libcurl4-openssl-dev libssl-dev jupyter-core jupyter-client nodejs
RUN conda install r-base r-repr r-IRdisplay r-IRkernel r-tidyverse
RUN R -e 'IRkernel::installspec(user = FALSE)'
RUN cp -r /usr/local/share/jupyter/kernels/ir /opt/conda/share/jupyter/

# Add python libraries
RUN conda install keras
RUN conda update --all
RUN pip install kaggle 

# Additional applications
RUN apt-get install -y htop

# Generate Jupyter notebook config file
RUN jupyter notebook --generate-config

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]