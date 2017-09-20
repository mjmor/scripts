parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/B:\1/'
}

# stash
count_git_stash() {
    git stash list 2> /dev/null | wc -l | sed 's/^ *//g'
}
render_git_stash() {
    if [[ "$(count_git_stash)" -gt 0 ]]; then
        echo " S: $(count_git_stash)"
    fi
}
