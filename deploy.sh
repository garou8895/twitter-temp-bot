#!/bin/bash

# make lambda layer
mkdir ./deploy
cd deploy/
pip3 install -U pip
pip install requests_oauthlib -t ./
cp ../lambda_function.py .
zip -r twitter-bot-hello.zip ./
mv twitter-bot-hello.zip ../

# cleanup
cd ../
rm -rf deploy