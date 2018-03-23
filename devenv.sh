#!/bin/bash

yum update 
yum install docker
systemctl enable docker
systemctl start docker
