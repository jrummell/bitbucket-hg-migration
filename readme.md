# Bitbucket Mercurial to Git Migration

**[Mercurial features and repositories will be officially removed from Bitbucket and its API on June 1, 2020](https://bitbucket.org/blog/sunsetting-mercurial-support-in-bitbucket)**

This project was created to share powershell scripts that make it easy to convert hg repositories in Bitbucket to git.

## Usage Instructions

### Configure Mercurial

Install Mercurial, if you haven't already. You can get it from <https://www.mercurial-scm.org/> or use [Chocolatey](https://chocolatey.org/packages/hg):

    > choco install hg

Clone [Hg-Git](https://bitbucket.org/durin42/hg-git), which lets hg interact with git repositories:

    > hg clone https://bitbucket.org/durin42/hg-git

Enable hg-git in your global Mercurial config file. You can typically find this file at `%USERPROFILE%\mercurial.ini` on Windows.

    [extensions]
    hggit = c:/path/to/hg-git/hggit

## Get the migration scripts

Clone this repository and make a note of path to the `migrate.ps1` and `push.ps1` scripts.

    > git clone https://github.com/jrummell/bitbucket-hg-migration

## Migrate

Execute the migrate script:

    > .\migrate.ps1 -BitbucketAccount username -Repository repo-name

This will

- clone the hg repository to `.\username\repo-name-hg`
- create a bare git repository at `.\username\repo-name-git`
- push all commits from the hg repository to the git repository

For example, if your hg repository is `https://bitbucket.org/jrummell/bitbucket-hg-migration/`, use the following arguments:

    > .\migrate.ps1 -BitbucketAccount jrummell -Repository bitbucket-hg-migration

which will clone the hg repository to `.\jrummell\bitbucket-hg-migration-hg`, create a new bare git repository at `.\jrummell\bitbucket-hg-migration-git` and push to it.

## Create your git repository

Create a new git repository in Bitbucket.

## Push

    > .\push.ps1 -BitbucketAccount username -Repository git-repo-name

This will:

- push the local bare git repository created by the migrate script to your new git repository in Bitbucket

Using the same example:

    > .\push.ps1 -BitbucketAccount jrummell -Repository bitbucket-hg-migration

will push your new git repository to `.\jrummell\bitbucket-hg-migration-git`

## Conventions

These scripts use the following conventions/assumptions:

- You are converting your Bitbucket hg repository to a new git repository in Bitbucket.
- When you create a new git repository, it has the same name as the hg repository.
- You are using [SSH keys for authentication with Bitbucket](https://confluence.atlassian.com/bitbucket/ssh-keys-935365775.html).

For example, I used the following workflow to migrate about a dozen repositories:

- Clone an existing hg repository: `hg clone ssh://hg@bitbucket.org/jrummell/bitbucket-hg-migration`
- Execute `.\migrate.ps1 -BitbucketAccount jrummell -Repository bitbucket-hg-migration`
- Rename the hg repository in Bitbucket to `bitbucket-hg-migration-hg`
- Create a new git repository in Bitbucket with the original hg repository name `bitbucket-hg-migration`
- Execute `.\push.ps1 -BitbucketAccount jrummell -Repository bitbucket-hg-migration`

If your needs are different, or want different repository names, you can adjust the scripts accordingly, or simply use them as a starting point.

If you want your git repository in GitHub, for example, you could change the push script to push to GitHub instead.

## References

I used the following for references when creating these scripts:

- [Sunsetting Mercurial support in Bitbucket](https://bitbucket.org/blog/sunsetting-mercurial-support-in-bitbucket)
- [How to Convert a Mercurial Repository to Git on Windows](https://markheath.net/post/how-to-convert-mercurial-repository-to)
- [Hg-Git](https://bitbucket.org/durin42/hg-git)
- [Configuration files for Mercurial](https://www.mercurial-scm.org/doc/hgrc.5.html#files)
