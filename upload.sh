
comment=$1

#echo ${comment}
git add . && git commit -m ${comment} && git push
