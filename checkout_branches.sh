#!/bin/bash
reponame=$1
ndhid="anbu"
bitbucket_url_dest="http://192.168.56.156:7990/"
bitbucket_url_src="http://192.168.56.124:7990/"
personal_access_token_src="NTAwNTc2NDU1MTM0Oj6LOifGm25LUdDyIkAzUOe0234Q"
#personal_access_token_dest="Mjk1MDUzMzY1MjQyOhuSU26%2Fa2QtCPqU84zS57ufzHFw"
personal_access_token_dest="NzE5NjAwNTU3ODIxOkwvNTv9Wc0xeHMxwN2M0CHQefgx"
bitbucket_project_url_dest="http://192.168.56.156:7990/scm/apx0104"
bitbucket_project_url_src="http://192.168.56.124:7990/scm/test"
bitbucket_project_id_src=$2
bitbucket_project_id_dest=$3
rm -rf branch_list.txt
echo "==========CLONING==============";
git clone "https://$ndhid:$personal_access_token_src@$bitbucket_url_src/scm/$bitbucket_project_id_src/$reponame.git"
cd $reponame
git fetch --all
git pull --all
git fetch --all --tags
git branch -r
git branch -r > ./../branch_list.txt
git tag
cd ..
while read line; do 
echo $line; 
sed -i -e '/origin\/HEAD/d;s/origin\///g' branch_list.txt
done < branch_list.txt
echo "=========================";
while read line; do 
echo $line;
done < branch_list.txt
cd $reponame
echo "==========BRANCH LIST IN LOCAL===============";
git branch -l
while read line; do 
git checkout $line
echo ""
done < ./../branch_list.txt
echo "==========FINAL BRANCH LIST IN LOCAL===============";
git branch -l
echo "==========PULL ALL==============";
git fetch --all
git pull --all
echo "==========CURRENT GIT REMOTE URL===============";
git remote -v
#git remote set-url origin https://NDH00347:Mjk1MDUzMzY1MjQyOhuSU26%2Fa2QtCPqU84zS57ufzHFw@bitbucket.aws.na.nissancloud.biz/scm/apx0104/$reponame.git
#git remote set-url origin https://ndh00347:NjMxODA2NzY2MDA1OhxxrPXcxnuJxXwYPIutdmIcQjQA@bitbucket.devops-nissan.biz/scm/test/git_trng.git
git remote set-url origin "https://$ndhid:$personal_access_token_dest@$bitbucket_url_src/scm/$bitbucket_project_id_dest/$reponame.git"
echo "==========UPDATED GIT REMOTE URL===============";
git remote -v
echo "==========GIT branch ===============";
git branch -l
git branch -r > ./../branch_list_dest.txt
echo "==========GIT PUSH ===============";
git push -u origin --all
echo "==========GIT PUSH TAGS===============";
git push origin --tags
