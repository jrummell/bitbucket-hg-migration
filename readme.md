# Bitbucket Mercurial to Git

## Install Mercurial

Install Mercurial, if you haven't already. You can get it from <https://chocolatey.org/packages/hg>

    > choco install hg

## Get hg-git

    > hg clone https://bitbucket.org/durin42/hg-git

## Enable hg-git in ~/.hgrc

    [extensions]
    hggit = c:/path/to/hg-git/hggit

## Get the migration scripts

    > git clone TODO

## Convert

    > .\migrate.ps1 -BitbucketAccount username -Repository repo-name

- clones the hg repo to .\username\repo-name-hg
- creates a bare git repo at .\username\repo-name-git
- pushes all commits from the hg repo to the git repo

## Create your git repo

Create a new git repository in Bitbucket.

## Push converted repo

    > .\push.ps1 -BitbucketAccount username -Repository git-repo-name

- pushes your local bare git repository to your new Bitbucket git repository
