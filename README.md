# aws-lambda-py
Simple framework to develop and deploy AWS Lambda functions written in Python.

## requirements
* working setup of ```make``` (should be on every modern Linux/UNIX box)
* working setup of ```pip``` (either with or without virtualenv)
* working setup of the AWS CLI tool (including appropriate credentials)

## setup
Edit the provided ```Makefile``` and add the ARN of an approprite IAM Role. This
IAM Role has to exist in your AWS account and should allow at least
```logs:CreateLogStream``` and ```logs:PutLogEvents``` as a basic policy. Details
on setting up an appropriate IAM Role for you Lambda function can be found in the
[AWS Lambda Permissions Model](http://docs.aws.amazon.com/lambda/latest/dg/intro-permission-model.html#lambda-intro-execution-role)
documentation.

## development
Use the skeleton provided by ```lambda_function.py``` to get started. AWS Lambda
will call the function ```lambda_handler``` inside by default.

Add required Python modules to ```LIBS``` in the ```Makefile``` and run
```make deps```. Dependencies of the specified ```LIBS``` will not be resolved
automatically: To install ```LIBS``` make will call ```pip install``` with
```--no-deps``` to be able to cleanup properly with ```make clean```. You might
not need to vendor in every module dependency since AWS Lambda already provides
most of the modules. In question, or if you want to use a specific version, add
it to the ```LIBS``` in the ```Makefile```.

## deployment
Use ```make deploy``` in the console to deploy your application to AWS Lambda.

## advanced usage
Use ```make``` the console to see the available options.
