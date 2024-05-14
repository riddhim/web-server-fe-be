#!/bin/bash

#as mentioned
BRANCH_NAME=$1
SERVER_IPS=$2

# arguments are provided
if [ -z "$BRANCH_NAME" ] || [ -z "$SERVER_IPS" ]; then
    echo "Usage: $0 <branch_name> <server_ip1> <server_ip2> ..."
    exit 1
fi


#deploy

# deploy the backend app
deploy_backend() {
    local server_ip=$1
    git clone https://github.com/riddhim/backend.git
    cd backend
    git checkout $BRANCH_NAME
    ./gradlew build
    scp build/libs/backend.jar user@$server_ip:/var/www/backend/
    ssh user@$server_ip "java -jar /var/www/backend/backend.jar &"

    cd ..
    rm -rf backend
}

# deploy the backend app on each server
for server_ip in $SERVER_IPS; do
    deploy_backend $server_ip
done
