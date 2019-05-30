DIRSRC=~/user
DIRDST=/user
PORT=443
PASS=password
DIRKEY=letsencrypt/live/site
CERT=$DIRDST/$DIRKEY/fullchain.pem
PKEY=$DIRDST/$DIRKEY/privkey.pem

sudo docker run -d -p $PORT:$PORT -v $DIRSRC:$DIRDST  codercom/code-server -p $PORT -P $PASS $DIRDST --cert=$CERT --cert-key=$PKEY $DIRDST