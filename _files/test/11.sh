#!/bin/bash


username='test'
host="192.168.0.199"

actions="rm -rd bc && git clone https://github.com/ilopatenko/bc && cd bc && bash index.sh"


ssh -o StrictHostKeyChecking=no -l ${username} ${host} $actions