if [ "$GIT_BRANCH" = "origin/master" ]
then
  # Push rebased changes to jiocloud/master, and merged 
  # changes to jiocloud/devmaster

  git checkout -b jiocloud_master jiocloud/master;
  git rebase origin/master;
  tox -e py27;
  git push jiocloud jiocloud_master:master --force;

  # If rebase succeeds, then merge too will!
  # NOTE!: merge may not, as jiocloud/devmaster might have 
  # changed, but that is user's fault!
  git checkout -b jiocloud_devmaster jiocloud/devmaster;
  git branch -D jiocloud_master;
  git merge origin/master;
  git push jiocloud jiocloud_devmaster:devmaster;

  git checkout master;
  git branch -D jiocloud_devmaster;
elif [ "$GIT_BRANCH" = "jiocloud/manualmaster" ]
then
  git checkout -b jiocloud_manualmaster;
  tox -e py27;
  git push jiocloud jiocloud_manualmaster:master --force;
  git checkout master;
  git branch -D jiocloud_manualmaster;
elif [ "$GIT_BRANCH" = "jiocloud/devmaster" ]
then
  git checkout -b jiocloud_devmaster jiocloud/devmaster;
  git rebase jiocloud/master;
  tox -e py27;
  git push jiocloud jiocloud_devmaster:master --force;
  git checkout master;
  git branch -D jiocloud_devmaster;
elif [ "$GIT_BRANCH" = "jiocloud/master" ]
then
  echo "Not building jiocloud/master branch. Skipping";
else
  exit 1;
fi

