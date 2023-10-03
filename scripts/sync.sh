#!/bin/bash

{ # syncronize pass
    cd ~/.password-store
    GIT='git --git-dir=.git'
    {
        echo "push"
        $GIT push origin master
    } && {
        echo "pull"
        $GIT pull origin master
    }
}


{ # syncronise taskwarrior
    cd ~/.task
    GIT='git --git-dir=.git'
    {
        echo "add"
        $GIT add *
    } && {
        echo "commit"
        $GIT commit -m "update tasks"
    } && {
        echo "push"
        $GIT push origin main
    } && {
        echo "pull"
        $GIT pull origin main
    }
}
