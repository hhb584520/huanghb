# git
## git branch
### create 
   git checkout -b tst_y
   git push origin tst_y 
  
### delete
   git branch -d tst_y 
   git push origin --delete tst_y
   
### search
   git branch -a
  
### merge branch
   git checkout master
   git merge hotfix
  
### diff branch 
   git diff <source_branch> <target_branch> 
  
## git prompt
https://github.com/magicmonty/bash-git-prompt