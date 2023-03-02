#!/bin/bash


username='test'
host="192.168.0.101"

actions="git clone https://github.com/ilopatenko/bc && cd bc && bash index.sh"


ssh -o StrictHostKeyChecking=no -l ${username} ${host} $actions