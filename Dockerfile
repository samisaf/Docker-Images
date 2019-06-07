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

# Add Julia, and Julia kernel
RUN apt-get install -y htop julia
RUN JUPYTER=$(which jupyter) 
RUN julia -E "Pkg.status();Pkg.add("IJulia")"

# Generate Jupyter notebook config file
RUN jupyter notebook --generate-config

# Adds code server
RUN wget https://github.com/cdr/code-server/releases/download/1.1119-vsc1.33.1/code-server1.1119-vsc1.33.1-linux-x64.tar.gz \ 
    && tar -xf code-server1.1119-vsc1.33.1-linux-x64.tar.gz && cp -r ./code-server1.1119-vsc1.33.1-linux-x64/code-server /opt/
    
ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
