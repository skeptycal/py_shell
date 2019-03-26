#!/usr/bin/env python3
# -*- encoding: utf-8 -*-
###############################################################################
# py_shell.py 
#
# Returns: str -- python shell name. One of: ['IPython', 'IPython Notebook',
#          'Jupyter Notebook', ‘CPython’, ‘IronPython’, ‘Jython’, ‘PyPy’]
###############################################################################
def py_shell() -> str:
    """ Returns current python shell name.
    
        Returns:
            str -- python shell name. One of: ['IPython', 'IPython Notebook',
            'Jupyter Notebook', ‘CPython’, ‘IronPython’, ‘Jython’, ‘PyPy’]
        """
    import os

    PY_ENV: dict = os.environ
    PY_BASE: str = os.path.basename(PY_ENV['_'])
    shell: str = "shell"

    if "JPY_PARENT_PID" in PY_ENV:
        if "jupyter-notebook" in PY_BASE:
            shell = "Jupyter Notebook"
        else:
            shell = "IPython Notebook"
    elif "ipython" in PY_BASE:
        shell = "IPython"
    else: 
        # requires Python 2.6
        import platform 
        shell = platform.python_implementation()
    result = shell.strip()
    return result

if __name__ == "__main__":
    print("The current python shell is: ", py_shell())

###############################################################################
# - Tested on macOS version ...
# ProductName:	Mac OS X
# ProductVersion:	10.14.3
# BuildVersion:	18D109
# 24-Mar-2019
#
# @author    Michael Treanor  <skeptycal@gmail.com>
# @copyright (c) 2019 Michael Treanor
# @license   MIT <https://opensource.org/licenses/MIT>
# @link      http://www.github.com/skeptycal
###############################################################################
