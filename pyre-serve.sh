DIRSRC=~/user
DIRDST=/user
PORT=8000
CONDAPATH=/opt/conda/bin
DIRKEY=letsencrypt/live/site
CERT=$DIRDST/$DIRKEY/fullchain.pem
PKEY=$DIRDST/$DIRKEY/privkey.pem
PASS=$(python3 -c "from notebook.auth import passwd;print('c.NotebookApp.password=u\"{}\"'.format(passwd('passwd')))")
PASS=c.NotebookApp.password="u\'sha1:5cdced6aa09f:f3c99e12a3cd85facfc6a160dde4aab2cf60dfc1'"
CONFIGFILE=/root/.jupyter/jupyter_notebook_config.py

sudo docker run -p $PORT:$PORT -v $DIRSRC:$DIRDST pyre bash -c "echo $PASS >> $CONFIGFILE && $CONDAPATH/jupyter lab --port=$PORT --ip=0.0.0.0 --notebook-dir=$DIRDST --no-browser --allow-root --certfile=$CERT --keyfile=$PKEY $DIRDST"
