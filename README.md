# aws-lambda-py
Simple framework to develop and deploy AWS Lambda functions written in Python.

## Basic Requirements
* working setup of ```make``` (should be on every modern Linux/UNIX box)
* working setup of ```pip``` (either with or without virtualenv)
* working setup of the AWS CLI tool (including appropriate credentials)

## Setup
Edit the provided ```Makefile``` and add the ARN of an approprite IAM Role. This
IAM Role has to exist in your AWS account and should allow at least
```logs:CreateLogStream``` and ```logs:PutLogEvents``` as a basic policy. Details
on setting up an appropriate IAM Role for you Lambda function can be found in the
[AWS Lambda Permissions Model](http://docs.aws.amazon.com/lambda/latest/dg/intro-permission-model.html#lambda-intro-execution-role)
documentation.

## Develop your AWS Lamdba function
Use the skeleton provided by ```lambda_function.py``` to get started. AWS Lambda
will call the function ```lambda_handler``` inside by default.

Add required Python modules to ```LIBS``` in the ```Makefile``` and run
```make deps```. Dependencies of the specified ```LIBS``` will not be resolved
automatically: To install ```LIBS``` make will call ```pip install``` with
```--no-deps``` to be able to cleanup properly with ```make clean```. You might
not need to vendor in every module dependency since AWS Lambda already provides
most of the modules. In question, or if you want to use a specific version, add
it to the ```LIBS``` in the ```Makefile```.

## Deploy your AWS Lambda function
Use ```make deploy``` in the console to deploy your current code to AWS Lambda.
This will ensure your AWS Lambda function is created with or updated to your
current settings specified in the ```Makefile```, package your code, including
the ```LIBS``` specified in the Makefile and deploy it to your AWS Lambda
function.

## Run your AWS Lambda function
Use ```make run``` to deploy and run your application on AWS Lambda. This will
do everything included in ```make deploy``` plus invoking the AWS Lambda
function.

Use ```make invoke``` to run the currently deployed version of your AWS Lambda
function. ```make invoke``` is not only faster if you just want to rerun your
code, but also gives you some parsable output if you return JSON as a response
for example.

## Advanced Usage
Use ```make``` the console to see more available options.
