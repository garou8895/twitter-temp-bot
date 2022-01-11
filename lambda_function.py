import json
import os
import requests
from requests_oauthlib import OAuth1Session
import logging
from datetime import datetime, timedelta, timezone

# Timezone Setting
JST = timezone(timedelta(hours=+9), 'JST') 

# Logger Setting
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Twitter Access Token
consumer_key = os.environ['consumer_key']
client_secret = os.environ['client_secret']
access_token = os.environ['access_token']
access_token_secret = os.environ['access_token_secret']

# Swiitch Bot Token
switch_token = os.environ['switchbot_token']

# OpenWeather API Key
open_token = os.environ['openweather_token']

# Oauth settion setting
oauth = OAuth1Session(consumer_key, client_secret, access_token, access_token_secret)

# lat and lon
lat = os.environ['lat_pl']
lon = os.environ['lon_pl']

# Get Tenpture from switchbot
def getSwTemp():

    # Please get your access token via switchbot app
    header = {"Authorization": switch_token }

    # Get all device information in your switchbot hub
    response = requests.get("https://api.switch-bot.com/v1.0/devices", headers=header)
    devices  = json.loads(response.text)
    
    devices_id  = [device["deviceId"] for device in devices['body']['deviceList'] if "Meter" == device["deviceType"]]
    
    for device_id in devices_id:
        response = requests.get("https://api.switch-bot.com/v1.0/devices/" + device_id + "/status", headers=header)
        meter      = json.loads(response.text)

    return(meter['body']['temperature'])


def getOwTemp():
    response = requests.get("https://api.openweathermap.org/data/2.5/onecall?lat=" + lat + "&lon=" + lon + "&lang=ja&units=metric&appid=" + open_token)
    
    temp = json.loads(response.text)

    return temp['current']['temp']


def lambda_handler(event, context):
    
    logger.info(event)

    # Get Tempture
    hometemp = getSwTemp()
    outtemp = getOwTemp()
    difftemp = abs(hometemp - outtemp)

    now = datetime.now(JST).strftime("%Y年%-m月%-d日 %H:%M:%S") 
    text = 'おはようございます! \n\n' + now + '執務室の温度は ' + str(hometemp) + ' 度です!\n\n 外との温度差は'+  str(difftemp) +' 度です。\n\n\n頑張っていきましょう!!'
    
    payload = {'text': text}
    response = oauth.post(
        "https://api.twitter.com/2/tweets",
        json=payload,
    )
    if response.status_code != 201:
        raise Exception(
            "[Error] {} {}".format(response.status_code, response.text)
        )