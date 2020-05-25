########################################################################################################################
#
# Vars that shouldn't be edited
#
########################################################################################################################
OS               := $(shell uname)

########################################################################################################################
#
# HELP
#
########################################################################################################################

# COLORS
RED    = $(shell printf "\33[31m")
GREEN  = $(shell printf "\33[32m")
WHITE  = $(shell printf "\33[37m")
YELLOW = $(shell printf "\33[33m")
RESET  = $(shell printf "\33[0m")

########################################################################################################################
#
# FORMAT
#
########################################################################################################################

check-fmt: ##@format Check if terraform file have been properly formatted by formatting and checking git diff
	@echo "${YELLOW}Check if files where formatted${RESET}"
	terraform fmt
	@if [[ "$$(git diff --shortstat 2> /dev/null | tail -n1)" != "" ]]; then echo "Files where not properly formatted"; exit 1; fi;

########################################################################################################################
#
# DOC
#
########################################################################################################################

check-doc: ##@doc Check if documentation was updated by updating it and checking git diff
	@echo "${YELLOW}Check if documentation was updated${RESET}"
	tfdocs md . > doc.md
	@if [[ "$$(git diff --shortstat 2> /dev/null | tail -n1)" != "" ]]; then echo "Documentation wasn't updated"; exit 1; fi;
