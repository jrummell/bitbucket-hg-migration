param([string]$BitbucketAccount, [string] $Repository)

$gitRepo = "$Repository-git"

Set-Location $BitbucketAccount/$gitRepo

# push the local git repository to Bitbucket
git remote add origin git@bitbucket.org:$BitbucketAccount/$Repository.git
git push --all origin

Set-Location ..\..