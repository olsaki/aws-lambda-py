# aws-lambda-py
Simple framework to develop and deploy AWS Lambda functions written in Python.

## requirements
* working setup of ```pip``` (either with or without virtualenv)
* working setup of the AWS CLI tool (including appropriate credentials)

## development
Use the skeleton in ```lambda_function.py``` to get started.
Add required libraries to the ```LIBS``` section in the ```Makefile``` and run
```make deps```. Dependencies of ````LIBS``` will not be resolved automatically:
To install LIBS ```pip install``` is called with ```--no-deps``` to be able to
cleanup properly with ```make clean```.

## deployment
Use ```make deploy``` in the console to deploy your application to AWS Lambda.
