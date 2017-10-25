#!/bin/sh -e

supervisorctl -c /etc/supervisor/supervisord.conf status flexget | grep -q "RUNNING" || return 1
supervisorctl -c /etc/supervisor/supervisord.conf status transmission-daemon | grep -q "RUNNING" || return 1