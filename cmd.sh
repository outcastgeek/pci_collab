#!/bin/bash

ENV_NAME=PCIENV

upgrade_all_deps() {
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
}

clean_all() {
  rm -rf **/*.pyc
}

create_py2env() {
    conda create -n $ENV_NAME python=2 -y
}

activate_env() {
    source activate $ENV_NAME
}

case $1 in
    py2.create)
        create_py2env
        ;;
    py.delete)
        conda env remove -n $ENV_NAME -y
        ;;
    py.activate)
        activate_env
        ;;
    deps.upgrade)
        activate_env
        upgrade_all_deps
        ;;
    deps.list)
        activate_env
        pip list
        ;;
    deps.outdated)
        activate_env
        pip list --outdated
        ;;
    deps.freeze)
        activate_env
        pip freeze > requirements.txt
        ;;
    deps.install)
        activate_env
        pip install -r requirements.txt --upgrade
        ;;
    clean)
        clean_all
        ;;
    esac
exit 0
