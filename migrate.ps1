param([string]$BitbucketAccount, [string] $Repository)

# create variables for the git and hg repository folder names
$gitRepo = "$Repository-git"
$hgRepo = "$Repository-hg"

# create a folder for the given account
$accoutFolderExists = Test-Path $BitbucketAccount
if (!$accoutFolderExists)
{
    New-Item -ItemType Directory -Force -Path $BitbucketAccount
}

Set-Location $BitbucketAccount

# create a new bare git repository
git init --bare $gitRepo

# clone the hg repository from Bitbucket
hg clone ssh://hg@bitbucket.org/$BitbucketAccount/$Repository $hgRepo

Set-Location $hgRepo

# create an hg branch
hg bookmarks hg

# push the hg repository to the local git repository
hg push ../$gitRepo

Set-Location ..\..