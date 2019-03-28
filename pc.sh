#!/usr/bin/env bash
###############################################################################
    # pc.sh
    #
    # Usage: ./pc.sh
    #
    # Parameters:
    #
    #   NONE
    #
    #
    #   .pre-commit-template.yaml must be in current directory
    #   .pre-commit-bak.yaml will be created as backup
    #   .pre-commit-config.yaml will be overwritten
    #
    # @author    Michael Treanor  <skeptycal@gmail.com>
    # @copyright 2019 (c) Michael Treanor
    # @license   MIT <https://opensource.org/licenses/MIT>
    # @link      http://www.github.com/skeptycal
    #
    ###########################################################################

pc_version='

    #####################################################################
    pc.sh : pre-commit automation for macOS version 0.5.0

    Usage: ./pc.sh {init|version|help}

    copyright 2019 (c) Michael Treanor <https://www.github.com/skeptycal>
    MIT License <https://opensource.org/licenses/MIT>

    Usage: ./pc.sh {init|version|help}

'

pc_instructions='
#####################################################################
    pc.sh : pre-commit automation for macOS version 0.5.0

    copyright 2019 (c) Michael Treanor <https://www.github.com/skeptycal>
    MIT License <https://opensource.org/licenses/MIT>

    Usage: ./pc.sh {init|version|help}

Only run if changes to the yaml configuration are needed.

Please make changes directly to the "template" file:
    .pre-commit-template.yaml
and run the script "./pc.sh" from this directory to update this file.

Please do not make changes directly to the "config" file. The "config" file:
    .pre-commit-config.yaml
is created and updated by the pc.sh script found in the same directory
in order to maintain the correct, current versioning from git (master sha)

'

sample_template='
#####################################################################
#     pc.sh : pre-commit automation for macOS version 0.5.0

#     copyright 2019 (c) Michael Treanor <https://www.github.com/skeptycal>
#     MIT License <https://opensource.org/licenses/MIT>

#     Usage: ./pc.sh {init|version|help}

# Only run if changes to the yaml configuration are needed.

# Please make changes directly to the "template" file:
#     .pre-commit-template.yaml
# and run the script "./pc.sh" from this directory to update this file.

# Please do not make changes directly to the "config" file. The "config" file:
#     .pre-commit-config.yaml
# is created and updated by the pc.sh script found in the same directory
# in order to maintain the correct, current versioning from git (master sha)

default_language_version:
    python: python3.7
exclude: "^$"
fail_fast: false
repos:
-   repo: git://github.com/pre-commit/pre-commit-hooks
    sha: master
    hooks:
    -   id: check-added-large-files
    -   id: check-byte-order-marker
    -   id: check-docstring-first
    -   id: check-case-conflict
    -   id: check-json
    -   id: check-merge-conflict
    -   id: check-symlinks
    -   id: check-yaml
    -   id: detect-aws-credentials
    -   id: detect-private-key
    -   id: end-of-file-fixer
    -   id: flake8
    -   id: pretty-format-json
    -   id: requirements-txt-fixer
    -   id: trailing-whitespace
-   repo: git://github.com/pre-commit/mirrors-pylint
    sha: master
    hooks:
    -   id: pylint
'

if [ -n "$1" ]; then
    case "$1" in
        init)
            echo "$sample_template" >.pre-commit-template.yaml
            exit 0
            ;;

        version)
            echo $pc_version
            exit 0
            ;;

        help)
            echo $pc_instructions
            exit 0
            ;;

        *)
            echo "Invalid option: $1"
            echo ""
            echo "Usage: ./pc.sh {init|version|help}"
            exit 2
    esac
fi


if [ -f ".pre-commit-template.yaml" ]; then
    echo "-> template file located: .pre-commit-template.yaml"
    echo "-> backup file created: .pre-commit-config.yaml.bak"
    cp -pf .pre-commit-config.yaml .pre-commit-config.yaml.bak
    echo "-> config file created: .pre-commit-config.yaml"
    cp -pf .pre-commit-template.yaml .pre-commit-config.yaml
    pre-commit autoupdate
    return 0
else
    echo "No template file (.pre-commit-template.yaml) found in current directory."
    echo "Use <./pc.sh init> to create a new one."
    echo "No changes made..."
    echo ""
    return 126
fi


# automating pre-commit hooks for Git and GitHub
#
# instructions found on https://github.com/pre-commit/pre-commit/issues/366

# Correct solution from this post:

# Author: Tom Hensel (https://github.com/gretel)
#

# let me try:

# The value of sha should not be master or HEAD - both will only match the latest version at install time, and prevent subsequent updates.
# On GitHub, the id of the most recent commit can be looked up easily (i.e. commit/master).
# Alternatively, setting sha to master and running pre-commit autoupdate before anything else will automatically populate the values of the sha keys in the configuration file:

# -   repo: git://github.com/pre-commit/pre-commit-hooks
#     sha: master
#     hooks:
#     -   id: check-added-large-files
#     -   id: check-byte-order-marker
#     -   id: check-docstring-first
#     -   id: check-case-conflict
#     -   id: check-json
#     -   id: check-merge-conflict
#     -   id: check-symlinks
#     -   id: check-yaml
#     -   id: detect-aws-credentials
#     -   id: detect-private-key
#     -   id: end-of-file-fixer
#     -   id: flake8
#     -   id: pretty-format-json
#     -   id: requirements-txt-fixer
#     -   id: trailing-whitespace
# -   repo: git://github.com/pre-commit/mirrors-pylint
#     sha: master
#     hooks:
#     -   id: pylint
# which on running pre-commit autoupdate gets to

# -   repo: git://github.com/pre-commit/pre-commit-hooks
#     sha: 35548254adb636ce52b5574eb1904b8c795b673e
#     hooks:
#     -   id: check-added-large-files
#     -   id: check-byte-order-marker
#     -   id: check-docstring-first
#     -   id: check-case-conflict
#     -   id: check-json
#     -   id: check-merge-conflict
#     -   id: check-symlinks
#     -   id: check-yaml
#     -   id: detect-aws-credentials
#     -   id: detect-private-key
#     -   id: end-of-file-fixer
#     -   id: flake8
#     -   id: pretty-format-json
#     -   id: requirements-txt-fixer
#     -   id: trailing-whitespace
# -   repo: git://github.com/pre-commit/mirrors-pylint
#     sha: 4de6c8dfadef1a271a814561ce05b8bc1c446d22
#     hooks:
#     -   id: pylint
