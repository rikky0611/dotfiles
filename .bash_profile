PATH="$PATH":/Users/arakawariku/isrb2
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi
PYTHONPATH=/Users/arakawariku/yellow-submarine:$PYTHONPATH
export PYTHONPATH
export PATH="/usr/local/opt/libiconv/bin:$PATH"
