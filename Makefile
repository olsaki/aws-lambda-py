LIBS=
LAMBDA_FUNCTION_NAME=my-lambda-function

all:
	@echo "WELCOME TO THE '$(LAMBDA_FUNCTION_NAME)' BUILD SYSTEM"
	@echo "AVAILABLE OPTIONS:"
	@echo "make deps\tinstall depenecies (LIBS= from Makefile)"
	@echo "make package\tpackage application as $(LAMBDA_FUNCTION_NAME).zip file"
	@echo "make deploy\tdeploy application to AWS Lamdba"
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

deploy: package
	aws lambda update-function-code --function-name $(LAMBDA_FUNCTION_NAME) --zip-file fileb://$(LAMBDA_FUNCTION_NAME).zip

.PHONY: clean

clean:
	rm -rf $(LIBS); rm -rf $(LIBS)-*.dist-info

mrproper: clean
	rm -rf $(LAMBDA_FUNCTION_NAME).zip
