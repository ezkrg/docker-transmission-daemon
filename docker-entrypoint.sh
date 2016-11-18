#!/bin/bash

/usr/bin/flexget daemon start -d

/usr/bin/transmission-daemon -f --log-error

