# git branch
## create 
   git checkout -b tst_y
   git push origin tst_y 
  
## delete
   git branch -d tst_y 
   git push origin --delete tst_y
   
## search
   git branch -a
  
## merge branch
   git checkout master
   git merge hotfix
  
## diff branch 
   git diff <source_branch> <target_branch> 

# git patch
## see patch
   git log -p patch_id
   git diff commit_id~1..commit_id
## create patch
### favorite
   git format-patch -1 -o .      
   or 
   git format-parch -n HEAD~3    // 3 patches will be generated, their names look like [PATCH n/3]
   or 
   git format-patch commit_id -1 -o .
   
### by compare create patch
   git format-patch -M master -o outgoing
   git format-parch -M HEAD~1 -o .
   
# git tools
## prompt
https://github.com/magicmonty/bash-git-prompt
