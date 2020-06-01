
THIS_FILE := $(lastword $(MAKEFILE_LIST))
SELF_DIR := $(dir $(THIS_FILE))
.PHONY:  python-run python-clean python-pip-upgrade python-pip python-develop python-add-shebang python-print
.SILENT: python-run python-clean python-pip-upgrade python-pip python-develop python-add-shebang python-print
python-run:
	- $(call print_running_target)
	- $(call print_completed_target)

python-pip-upgrade:
	- $(call print_running_target)
	- python3 -m pip install --upgrade pip
	- $(call print_completed_target)
python-pip: python-pip-upgrade
	- $(call print_running_target)
	- $(call print_running_target, installing tsplib95)
	- python3 -m pip install --quiet tsplib95
	- $(call print_running_target, installing matplotlib)
	- python3 -m pip install --quiet matplotlib
	- $(call print_running_target, installing networkx)
	- python3 -m pip install --quiet networkx
	- $(call print_running_target, installing sympy)
	- python3 -m pip install --quiet sympy
	- $(call print_running_target, installing numpy)
	- python3 -m pip install --quiet numpy
	- $(call print_running_target, installing setuptools)
	- python3 -m pip install --quiet setuptools
	- $(call print_running_target, installing pandas)
	- python3 -m pip install --quiet pandas
	- $(call print_running_target, installing tabulate)
	- python3 -m pip install --quiet tabulate
	- $(call print_completed_target)

python-develop: python-add-shebang
	- $(call print_running_target)
	- python3 $(PWD)$(PSEP)setup.py develop
	- $(call print_completed_target)
python-add-shebang: 
	- $(call print_running_target)
	- $(PWD)$(PSEP)contrib$(PSEP)scripts$(PSEP)add_shebang
	- $(call print_completed_target)
python-clean:
	- $(call print_running_target)
	- $(call print_running_target, running setup.py clean)
	- python3 $(PWD)$(PSEP)setup.py clean
	- $(call print_running_target, removing egg-info directories)
	- $(RM) $(PWD)$(PSEP)*.egg-info
	- $(call print_running_target, removing __pycache__ directories)
	- $(RM) $(call rwildcard,$(PWD)/project_template/__pycache__)
	- $(RM) $(call rwildcard,$(PWD)/project_template/*/__pycache__)
	- $(call print_completed_target)
python-print:
	- $(call print_running_target)
	- $(call print_completed_target)



