DIRSRC=~/Sami
DIRDST=/Sami
PORT=8300
CONDAPATH=/opt/conda/bin
DIRKEY=/etc/letsencrypt
CERT=$DIRKEY/live/www.ssafadi.xyz/fullchain.pem
PKEY=$DIRKEY/live/www.ssafadi.xyz/privkey.pem
#PASS=$(python3 -c "from notebook.auth import passwd;print('c.NotebookApp.password=u\"{}\"'.format(passwd('mypassword')))")
PASS=c.NotebookApp.password="u\'sha1:f6ddf5b5e7b4:b5c5a36f3264a9272e3cbab4da519d607a8f3c81\'"
CONFIGFILE=/root/.jupyter/jupyter_notebook_config.py
KAGGLE_USERNAME=mykagglename
KAGGLE_KEY=mykagglepasswd
GIT_E=myemail
GIT_U=myusername

sudo docker run --name awsomepy --rm -d -p $PORT:$PORT -v $DIRSRC:$DIRDST -v $DIRKEY:$DIRKEY \
	-e KAGGLE_USERNAME=$KAGGLE_USERNAME -e KAGGLE_KEY=$KAGGLE_KEY samisaf/pyre bash -c \
	"git config --global user.email $GIT_E && git config --global user.name $GIT_U && echo $PASS >> $CONFIGFILE && \
	$CONDAPATH/jupyter lab --port=$PORT --ip=0.0.0.0 --notebook-dir=$DIRDST --no-browser --allow-root --certfile=$CERT --keyfile=$PKEY"

