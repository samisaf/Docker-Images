DIRSRC=~/myuser
DIRDST=/myuser
PORT=443
CONDAPATH=/opt/conda/bin
DIRKEY=/etc/letsencrypt
CERT=$DIRKEY/live/www.mywebsite.com/fullchain.pem
PKEY=$DIRKEY/live/www.mywebsite.com/privkey.pem
#PASS=$(python3 -c "from notebook.auth import passwd;print('c.NotebookApp.password=u\"{}\"'.format(passwd('mypassword')))")
PASS=c.NotebookApp.password="u\'sha1:f7633984f6a3:8de6afbf4a7fe9b3b0bd86a6ee2d7d6d9231e981\'"
CONFIGFILE=/root/.jupyter/jupyter_notebook_config.py

sudo docker run --rm -p $PORT:$PORT -v $DIRSRC:$DIRDST -v $DIRKEY:$DIRKEY samisaf/pyre bash -c \
    "echo $PASS >> $CONFIGFILE && $CONDAPATH/jupyter lab --port=$PORT --ip=0.0.0.0 --notebook-dir=$DIRDST --no-browser --allow-root --certfile=$CERT --keyfile=$PKEY"
