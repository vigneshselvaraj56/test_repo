#!/bin/bash

USERNAME=$1
PASSWORD=$2

git clone 'https://${USERNAME}:${PASSWORD}@github.com/vigneshselvaraj56/test_repo.git'

echo `hostname`
