unalias gcm 2>/dev/null
gcm() {
  local branch
  branch=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null)
  branch=${branch#origin/}
  if [[ -z $branch ]]; then
    for candidate in main master; do
      if git show-ref --verify --quiet "refs/heads/$candidate"; then
        branch=$candidate
        break
      fi
    done
  fi
  if [[ -z $branch ]]; then
    echo "gcm: could not determine default branch" >&2
    return 1
  fi
  git checkout "$branch"
}

gpo() {
  git push origin $(git branch | grep \* | cut -d ' ' -f2)
}

gpof() {
  git push origin $(git branch | grep \* | cut -d ' ' -f2) -f
}

gro() {
  git pull origin $(git branch | grep \* | cut -d ' ' -f2) --rebase
}