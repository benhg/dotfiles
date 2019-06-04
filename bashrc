eval $(thefuck --alias)

##
# Your previous /Users/ben/.bash_profile file was backed up as /Users/ben/.bash_profile.macports-saved_2017-05-25_at_10:40:56
##

# MacPorts Installer addition on 2017-05-25_at_10:40:56: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ben/google-cloud-sdk/path.bash.inc' ]; then source '/Users/ben/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ben/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/ben/google-cloud-sdk/completion.bash.inc'; fi

source ~/.bashrc
export LDFLAGS="-L/usr/local/opt/libffi/lib"export PATH="/usr/local/opt/llvm/bin:$PATH"

alias ompcc="gcc -Xpreprocessor -fopenmp -lomp" 
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
