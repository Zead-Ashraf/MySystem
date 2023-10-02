#!/bin/bash

function get_repo_name() {
    url_cuted=true
    repo_url=$1
    repo_name=$(echo $repo_url | cut -d":" -f2-)
    while $url_cuted; do
        if [[ $(echo $repo_name | grep -G "/" -o) != "" ]]; then
                repo_name=$(echo $repo_url | cut -d"/" -f2-)
                repo_url=$repo_name
        else
            url_cuted=false
            repo_name="${repo_name%\"}"
        fi
    done
    # echo $repo_name
}

function clean_task_list() {
    task +issue delete purge
}

function add_task() {
    issue=$1
    repo_name=$2
    issue="${issue#\"}"
    issue="${issue%\"}"
    task add "$issue" project:"$repo_name" +issue
}

outputs=$(curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <Your-Token>" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/issues) 

i=0
clean_task_list
for output in $outputs; do
    issue=$(echo $outputs | jq ".[$i]" | jq ".title")
    url=$(echo $outputs | jq ".[$i]" | jq ".html_url")
    repo_url=$(echo $outputs | jq ".[$i]" | jq ".repository_url")
    if [[ $issue == null ]]; then
        break
    else
        get_repo_name $repo_url
        add_task "$issue" "$repo_name"
        i=$((i+1))
    fi
done
