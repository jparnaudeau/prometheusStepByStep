#!/usr/bin/env python

import prometheus_client as prom
import random
import time
import sys
import os


def createGauge(metric_name,description):
    return prom.Gauge(metric_name,description,['status','env','nb'])


if __name__ == '__main__':

    listen_port    = os.environ.get('EXPORTER_LISTEN_PORT','4444')
    polling_period = os.environ.get('POLLING_PERIOD','1')  # minute
    environment    = os.environ.get('ENVIRONMENT','test')
    
    # start server for responding to prometheus
    prom.start_http_server(int(listen_port))

    # create a map of custom gauges
    mapGauges = {}
    mapGauges['current_random'] = createGauge('current_random', 'Current Random Value')
    mapGauges['custom_metric']  = createGauge('custom_metric', 'A Custom Metric')

    # create a map for storing count
    mapValues = {}

    while True:

        # generate a random number between 1 - 100
        randomNumber1 = random.randint(0, 100)
        customMetricLabel = str(randomNumber1)

        if customMetricLabel in mapValues:
            mapGauges['custom_metric'].inc()
        else:
            mapValues[customMetricLabel] = 1
            mapGauges['custom_metric'].labels(nb=str(randomNumber1),env=environment,status='dot').set(1)
        
        # store the random number in a another metric
        mapGauges['current_random'].labels(status="global",env=environment,nb='0').set(randomNumber1)

        #print(str(mapValues))

        # wait during the polling period (in seconds)
        time.sleep(int(polling_period) )

