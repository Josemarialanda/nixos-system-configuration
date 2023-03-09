if test -z '$1'; then
  echo "You forgot to enter a commit message."
else
  git add --all
  git commit -m '$1'
  git push --set-upstream origin master
fi