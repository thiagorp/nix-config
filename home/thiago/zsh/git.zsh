gpo() {
  git push origin $(git branch | grep \* | cut -d ' ' -f2)
}

gpof() {
  git push origin $(git branch | grep \* | cut -d ' ' -f2) -f
}

gro() {
  git pull origin $(git branch | grep \* | cut -d ' ' -f2) --rebase
}