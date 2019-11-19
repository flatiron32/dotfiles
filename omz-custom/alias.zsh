alias resource='exec zsh'

##### GIT ALIASES #####
alias gs='git status'
alias gsd='echo; ~/.git-branch-status -va; echo; git status; echo; git --no-pager log -1; echo; echo "CURRENT TIME: `date`"; echo'
alias gbc="git status | awk '{print \$3}' | head -n 1 | pbcopy"

function local_git_check() {
  for repo in $(locate .git | grep git$ | grep -v "Homebrew" | sed 's/\/.git//g')
  do
    cd $repo
    git pull --all
    res=$(gsd)
    if [[ $res != *up-to-date* ]] || [[ $res == *"Untracked files"* ]] || [[ $res == *"Changes not staged"*  ]]
    then
      gsd
      break
    fi
  done
}

function remaster() {
  BRANCH=$(git status | awk '{print $3}' | head -n 1)
  git checkout master
  git pull --prune
  git checkout ${BRANCH}
  git rebase $1 master
}

#### APP ALIASES ####
alias f='fuck'
