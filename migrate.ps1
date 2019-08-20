param([string]$BitbucketAccount, [string] $Repository)

$gitRepo = "$Repository-git"
$hgRepo = "$Repository-hg"

$accoutFolderExists = Test-Path $BitbucketAccount
if (!$accoutFolderExists)
{
    New-Item -ItemType Directory -Force -Path $BitbucketAccount
}

Set-Location $BitbucketAccount

git init --bare $gitRepo

hg clone ssh://hg@bitbucket.org/$BitbucketAccount/$Repository $hgRepo

Set-Location $hgRepo

hg bookmarks hg

hg push ../$gitRepo

Set-Location ..\..