COMMIT_TITLE=$(date)
COMMIT_MSG=$1

if test -z '$1'; then
  echo "You forgot to enter a commit message."
else
  git add --all
  git commit -m "$COMMIT_TITLE:$COMMIT_MSG"
  git push --set-upstream origin master
fi