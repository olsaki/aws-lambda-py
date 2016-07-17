LIBS=
LAMBDA_FUNCTION_NAME=my-lambda-function
DESCRIPTION=This is my Lambda function
RUNTIME=python2.7
HANDLER=lambda_function.lambda_handler
IAM_ROLE=

all:
	@echo "WELCOME TO THE '$(LAMBDA_FUNCTION_NAME)' BUILD SYSTEM"
	@echo "AVAILABLE OPTIONS:"
	@echo "make deps\tinstall depenecies (LIBS= from Makefile)"
	@echo "make package\tpackage application as $(LAMBDA_FUNCTION_NAME).zip file"
	@echo "make deploy\tdeploy application to AWS Lamdba"
	@echo "make release\trelease as new application version to AWS Lambda"
	@echo "make clean\tclean up vendored libraries"
	@echo "make mrproper\tclean up everything"

deps:
	pip install $(LIBS) --no-deps -t .

upgrade-deps:
	pip install $(LIBS) --no-deps --upgrade -t .

force-deps:
	pip install $(LIBS) --no-deps --force-reinstall -t .

package: deps
	zip -r9 $(LAMBDA_FUNCTION_NAME).zip $(LIBS) lambda_function.py

setup:
	aws lambda create-function --function-name $(LAMBDA_FUNCTION_NAME) --runtime $(RUNTIME) --role $(IAM_ROLE) --handler $(HANDLER) --description "$(DESCRIPTION)" --zip-file fileb://$(LAMBDA_FUNCTION_NAME).zip || aws lambda update-function-configuration --function-name $(LAMBDA_FUNCTION_NAME) --runtime $(RUNTIME) --role $(IAM_ROLE) --handler $(HANDLER) --description "$(DESCRIPTION)"

deploy: package setup
	aws lambda update-function-code --function-name $(LAMBDA_FUNCTION_NAME) --zip-file fileb://$(LAMBDA_FUNCTION_NAME).zip

release: deploy
	aws lambda publish-version --function-name $(LAMBDA_FUNCTION_NAME)

invoke:
	@aws lambda invoke --function-name $(LAMBDA_FUNCTION_NAME) $(LAMBDA_FUNCTION_NAME).log > /dev/null
	@cat $(LAMBDA_FUNCTION_NAME).log
	@echo

run: deploy invoke

.PHONY: clean

clean:
	rm -rf $(LIBS); rm -rf $(LIBS)-*.dist-info

mrproper: clean
	rm -rf $(LAMBDA_FUNCTION_NAME).zip
