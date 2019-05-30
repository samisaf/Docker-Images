FROM debian:latest

# based on continuumio/anaconda3
# docker build . -t samisaf/pyre:latest
# docker run --rm -ti samisaf/pyre:latest
# docker push samisaf/pyre:latest

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion \
    libzmq3-dev libcurl4-openssl-dev libssl-dev jupyter-core jupyter-client nodejs

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

# Add R kernel to jupyter notebook
RUN conda install keras r-base r-repr r-IRdisplay r-IRkernel

RUN R -e 'IRkernel::installspec(user = FALSE)'

RUN cp -r /usr/local/share/jupyter/kernels/ir /opt/conda/share/jupyter/

# Generate Jupyter notebook config file
RUN jupyter notebook --generate-config

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]