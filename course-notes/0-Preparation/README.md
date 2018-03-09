# Blockchain Bootcamp

## Before the course

Make sure your MacBook has the following installed.

* either XCode or just the [Command Line Tools](https://developer.apple.com/download/more/)

        xcode-select --install

* [Zoom](https://zoom.us)
* [Chrome](https://chrome.google.com)

    * and the [MetaMask plugin](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=en) . Don't worry about setting it up, we'll cover that in the course.
    * and the [React](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en) and [Redux](https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en) dev-tools.

* [homebrew](https://brew.sh/)

        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)

* [nvm](https://github.com/creationix/nvm)

        brew install nvm

* [Node version 9.8.0](https://nodejs.org)

        nvm install 9.8.0
        nvm default node

* [Docker for Mac](https://docs.docker.com/docker-for-mac/)
* [truffle](http://truffleframework.com/)

        npm install -g truffle

### Other things it is good to have installed

* [`bash completion`](http://davidalger.com/development/bash-completion-on-os-x-with-brew/)

        brew install bash-completion
        brew tap homebrew/completions

    add the following to your `bash_profile` (or equivalent)

        [[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
        nvm use default

* [`git flow`](https://github.com/nvie/gitflow/wiki/Mac-OS-X) and also read [A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/) by Vincent Driessen, the inventor of Git Flow.

        brew install git-flow

    * also install [git-flow-completion](https://github.com/bobthecow/git-flow-completion). You'll thank me.

      Then add

          source /usr/local/etc/git-flow-completion/git-flow-completion.bash

      to your `.bash_profile`

* other handy `.bash_profile` things

        # Git branch in prompt.
        parse_git_branch() {
          git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
        }
        export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

        # no core files please
        ulimit -S -c 0 > /dev/null 2>&1

        # better list
        alias ll='ls -la'

        # Set architecture flags for X86 64 BIT
        export ARCHFLAGS="-arch x86_64"
