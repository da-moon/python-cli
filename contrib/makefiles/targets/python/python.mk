
THIS_FILE := $(lastword $(MAKEFILE_LIST))
SELF_DIR := $(dir $(THIS_FILE))
.PHONY:  python-clean
.SILENT: python-clean
python-clean:
	- $(call print_running_target)
	- $(eval command=$(RM) dist)
	- $(eval command=${command} && $(RM) build)
	- $(eval command=${command} && $(RM) poetry.lock)
	- $(eval command=${command} && $(RM) .mypy_cache)
	- $(eval command=${command} && $(RM) .venv)
	- $(eval command=${command} && $(RM) .pytest_cache)
	- $(eval command=${command} && find $(PWD) -type d -name '__pycache__' | xargs -I {} rm -rf {})
	- $(eval command=${command} && find $(PWD) -type f -name '*.py.*' | xargs -I {} rm -f {})
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) shell cmd="${command}"
	- $(call print_completed_target)

.PHONY:  python
.SILENT: python
python:
	- $(call print_running_target)
	- $(call print_running_target,listing targets defined in contrib/makefiles/targets/python/python.mk ...)
	- $(call print_running_target,++ make python-clean python-pex)
ifneq ($(DELAY),)
	- sleep $(DELAY)
endif
	- $(call print_completed_target)
.PHONY:  python-pex
.SILENT: python-pex
python-pex: python-clean
	- $(call print_running_target)
	- $(call print_running_target, making self-contained python executable with pex)
	- $(eval name=$(@:python-%=%))
	- $(eval entry_root=project_template)
	- $(eval command=poetry install)
	- $(eval command=${command} && poetry shell)
	- $(eval command=${command} && pex)
ifneq (${VERBOSE}, )
ifeq (${VERBOSE} , true)
	- $(eval command=${command} -v)
endif
endif
	- $(eval command=${command} --disable-cache)
	- $(eval command=${command} --compile)
	- $(eval command=${command} --venv)
	- $(eval command=${command} --jobs `nproc`)
	- $(eval command=${command} --entry-point $(entry_root).__main__:main)
	- $(eval command=${command} --output-file dist/$(name)/$(PROJECT_NAME))
	- $(eval command=${command} .)
	- $(eval command=${command} && chmod +x dist/$(name)/$(PROJECT_NAME))
	- $(eval command=${command} && dist/$(name)/$(PROJECT_NAME) version)
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) shell cmd="${command}"
	- $(call print_running_target, '$(name)' generated artifact stored at dist/$(name)/$(PROJECT_NAME))
	- $(call print_completed_target)