include vars.mk
include contrib/makefiles/pkg/base/base.mk
include contrib/makefiles/pkg/string/string.mk
include contrib/makefiles/pkg/color/color.mk
include contrib/makefiles/pkg/functions/functions.mk
include contrib/makefiles/targets/buildenv/buildenv.mk
include contrib/makefiles/targets/git/git.mk
include contrib/makefiles/targets/dependency/dependency.mk
include contrib/makefiles/targets/python/python.mk
THIS_FILE := $(firstword $(MAKEFILE_LIST))
SELF_DIR := $(dir $(THIS_FILE))
.PHONY:init
.SILENT: init
init:
	- $(call print_running_target)
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) python-init
	- $(call print_completed_target)
	
.PHONY: kill
.SILENT: kill
kill:
	- $(call print_running_target)
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) python-kill-server
	- $(call print_completed_target)
.PHONY: server 
.SILENT: server
server: python-server
	- $(call print_running_target)
	- $(call print_completed_target)
.PHONY:build
.SILENT: build
build:
	- $(call print_running_target)
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) python-pex
	- $(call print_completed_target)

.PHONY:clean
.SILENT: clean
clean:
	- $(call print_running_target)
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) python-clean
	- $(RM) tmp
	- $(MKDIR) tmp
	- $(call print_completed_target)
.PHONY:  targets
.SILENT: targets
targets:
	- $(call print_running_target)
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) python
	- @$(MAKE) --no-print-directory -f $(THIS_FILE) dependency
	- $(call print_completed_target)
