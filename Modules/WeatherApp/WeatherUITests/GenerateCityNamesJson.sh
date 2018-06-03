#!/bin/sh

#  GenerateCityNamesJson.sh
#  WeatherApp
#
#  Created by Grigory Entin on 03/06/2018.
#  Copyright © 2018 Grigory Entin. All rights reserved.

cityCount="${1:?}"; shift
cityListJsonGZ="${1:?}"; shift

gzcat "${cityListJsonGZ:?}" | jq [.[].name][0:${cityCount:?}]
