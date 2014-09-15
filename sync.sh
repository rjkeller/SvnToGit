rm -rf changes.diff ycs svnYcs

git clone https://github.com/YLighting-YLiving/ycs
svn co -q svn://svn.yliving.net/branches/yrga_dev/1.2 svnYcs
find svnYcs -name .svn -exec rm -rf {} \;
find . -empty -type d -delete

diff -ruw --exclude=".git" ycs svnYcs > changes.diff

if [ -s changes.diff ]
then
  cd ycs
  git rm -r *

  cd ../svnYcs
  cp -rf * ../ycs

  cd ../ycs
  git add *
  git commit -m "syncing svn with git. check svn log for blame information."

  echo "Changes waiting to be pushed!"

else
  echo "No changes detected!"

fi
