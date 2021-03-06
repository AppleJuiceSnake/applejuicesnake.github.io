git add ./
if ! git diff-index --quiet HEAD --; then
    printf "Please write the git commit message.\n"
    rm gitmsg
    printf "Committing these files:\n"
    sleepingtime=2
    for i in $(git diff --name-only); do
        printf "#\t%s\n" $i
        ((sleepingtime++))
    done
    sleep $sleepingtime
    nano gitmsg
    git commit -F gitmsg
    git pull --no-commit
    git push 
    rm gitmsg
    printf "Finished commiting and merging of repo.\n"
else
    printf "There's nothing to commit, so make some changes to commitable files or make sure they're not being ignored%s\n" "!"
    printf "." && sleep 1 && printf "." && sleep 1 && printf ".\n" && sleep 1
    printf "But, even if there's nothing to commit, we're going to still attempt a merge%s\n" "!"
    if git merge; then
        printf "Finished merging of repo or nothing to merge anyways.\n"
    else
        printf "Merge somehow errored.\n"
    fi
fi
