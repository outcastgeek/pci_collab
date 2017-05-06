
BASEDIR = $(shell pwd)
CMD = $(BASEDIR)/cmd.sh

create-env:
	$(CMD) py2.create

destroy-env:
	$(CMD) py.delete

deps-install:
	$(CMD) deps.install

notebook:
	$(CMD) py.notebook

