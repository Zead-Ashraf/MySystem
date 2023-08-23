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

outputs=$(curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <YOUR-TOKEN>" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/issues) 

i=0
issues_list=""
declare -a issues_arr
for output in $outputs; do
    issue=$(echo $outputs | jq ".[$i]" | jq ".title")
    url=$(echo $outputs | jq ".[$i]" | jq ".html_url")
    repo_url=$(echo $outputs | jq ".[$i]" | jq ".repository_url")
    if [[ $issue == null ]]; then
        break
    else
        issue="${issue#\"}"
        issue="${issue%\"}"
        get_repo_name $repo_url
        issues_list+="$i- $issue [ $repo_name ]\n"
        issues_arr+=( $url )
        url="${url#\"}"
        url="${url%\"}"
        i=$((i+1))
    fi
done



choosed_issue=$(echo -e "$issues_list" | dmenu -l 5 -p "choose issue:")

issue_index=$(echo $choosed_issue | cut -c 1)

issue_url=${issues_arr[$issue_index]}
issue_url="${issue_url#\"}"
issue_url="${issue_url%\"}"

if [[ -z $choosed_issue ]]; then
    echo "you have choosed nothing"
else
    firefox --new-tab $issue_url 
fi



