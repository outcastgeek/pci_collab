#!/bin/bash

ENV_NAME=PCIENV

upgrade_all_deps() {
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
}

clean_all() {
  rm -rf **/*.pyc
}

create_py2env() {
    conda create -n $ENV_NAME python=2
}

case $1 in
    py2.create)
        create_py2env
        ;;
    py.delete)
        conda env remove -n $ENV_NAME
        ;;
    py.activate)
        source activate $ENV_NAME
        ;;
    deps.upgrade)
        upgrade_all_deps
        ;;
    deps.list)
        pip list
        ;;
    deps.outdated)
        pip list --outdated
        ;;
    deps.freeze)
        pip freeze > requirements.txt
        ;;
    deps.install)
        pip install -r requirements.txt --upgrade
        ;;
    clean)
        clean_all
        ;;
    esac
exit 0
