include vars.mk
include contrib/makefiles/pkg/base/base.mk
include contrib/makefiles/pkg/string/string.mk
include contrib/makefiles/pkg/color/color.mk
include contrib/makefiles/pkg/functions/functions.mk
include contrib/makefiles/targets/buildenv/buildenv.mk
include contrib/makefiles/targets/python/python.mk
THIS_FILE := $(firstword $(MAKEFILE_LIST))
SELF_DIR := $(dir $(THIS_FILE))

.PHONY: run init clean print
.SILENT: run init clean print
run: 
	- $(call print_running_target)
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) python-run
	- $(call print_completed_target)

init: 
	- $(call print_running_target)
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) python-clean
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) python-pip
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) python-develop
	- $(call print_completed_target)
clean:
	- $(call print_running_target)
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) python-clean
	- $(call print_completed_target)
print:
	- $(call print_running_target)
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) python-print
	- $(call print_completed_target)
