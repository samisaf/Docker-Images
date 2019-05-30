DIRSRC=~/myuser
DIRDST=/myuser
PORT=443
PASS=mypassword
DIRKEY=letsencrypt/live/www.mywebsite.com
CERT=$DIRDST/$DIRKEY/fullchain.pem
PKEY=$DIRDST/$DIRKEY/privkey.pem

sudo docker run --rm -d -p $PORT:$PORT -v $DIRSRC:$DIRDST \
    codercom/code-server -p $PORT -P $PASS $DIRDST --cert=$CERT --cert-key=$PKEY $DIRDST