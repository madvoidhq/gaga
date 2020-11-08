<!-- omit in toc -->
# Contributing

First, thank you for contributing! The goal of this document is to provide
everything you need to start working on the project.

We want contributing to be fun, enjoyable, and educational for anyone and
everyone. All contributions are welcome, including issues, new docs as well as
updates, tweaks, and more.

<!-- omit in toc -->
## What’s In This Document

- [Introduction](#introduction)
- [Your First Contribution](#your-first-contribution)
- [Change Control](#change-control)
  - [Git Branches](#git-branches)
  - [Git Commits](#git-commits)
  - [Github Pull Requests](#github-pull-requests)
- [Development](#development)
  - [Setup](#setup)
  - [Getting Started](#getting-started)
- [Legal](#legal)
  - [DCO](#dco)
  - [Granted rights and copyright assignment](#granted-rights-and-copyright-assignment)
- [FAQ](#faq)
  - [Why a DCO instead of a CLA?](#why-a-dco-instead-of-a-cla)
  - [If I’m contributing while an employee, do I still need my employer to sign something?](#if-im-contributing-while-an-employee-do-i-still-need-my-employer-to-sign-something)
  - [What if I forgot to sign my commits?](#what-if-i-forgot-to-sign-my-commits)
- [Contact](#contact)

## Introduction

1. **You're familiar with [Github](https://github.com) and the pull request workflow.**

## Your First Contribution

1. We typically recommend [opening an issue][urls.new_issue] before a pull
   request if there isn’t [already an issue][urls.existing_issues] for the
   problem you’d like to solve. This helps facilitate a discussion before
   deciding on an implementation.
2. [Fork the Gaga repository][urls.fork_repo] in your own Github
   account.
3. [Create a new Git branch][urls.create_branch].
4. Review the Gaga [development](#development).
5. Make your changes.
6. [Submit the branch as a pull request][urls.submit_pr] to the main Gaga repo.

## Change Control

### Git Branches

_All_ changes must be made in a branch and submitted as [pull
requests](#pull-requests). Gaga does not adopt any type of branch naming style,
but please use something descriptive of your changes.

### Git Commits

<!-- omit in toc -->
#### 3.2.1. Style

Please ensure your commits are small and focused; they should tell a story of
your change. This helps reviewers to follow your changes, especially for more
complex changes.

<!-- omit in toc -->
#### 3.2.2. Signing-off

Your commits must include a [DCO](https://developercertificate.org/) signature.
This is simpler than it sounds; it just means that all of your commits must
contain:

```text
Signed-off-by: Joe Smith <joe.smith@email.com>
```

Git makes this easy by adding the `-s` or `--signoff` flags when you commit:

```bash
git commit -sm 'My commit message'
```

If you forgot to sign your last commit, you can also use:

```bash
git commit --amend --signoff
```

### Github Pull Requests

Once your changes are ready you must submit your branch as a [pull
request][urls.pull_requests].

<!-- omit in toc -->
#### 3.3.1. Title

The pull request title must follow the format outlined in the [conventional
commits spec](https://www.conventionalcommits.org):

```
<type>: <description>
```

[Conventional commits](https://www.conventionalcommits.org) is a standardized
format for commit messages. We use it to update the Changelog with each commit
message and upgrade the package version.

As we squashes commits before merging branches, only the pull request title must
conform to this format.

The following are all good examples of pull request titles:

```text
feat: add for bar baz feature
fix: fix foo bar baz bug
chore: improve build process
docs: fix typos
```

If your commit introduce a breaking change, append a `!` after the `type`:

```text
chore!: drop support for foo bar baz
```

## Development

### Setup

We're super excited to have you interested in working on Gaga!

To build Gaga on your own host you'll need the following:

- erlang
- elixir
- node.js

You can find the required versions in [.tool-versions](./.tool-versions). If you
are using [asdf](https://asdf-vm.com/), you just have to run `asdf install` to
get up and running.

### Getting Started

1. Install Elixir dependencies with:

        mix deps.get

2. Install Node.js dependencies with:

        pushd assets && npm install && popd

3. Start Phoenix server with:

        mix phx.server

4. Now you can visit [`localhost:4000`](http://localhost:4000) from your
   browser.

## Legal

To protect all users of Gaga, the following legal requirements are made. If you
have additional questions, please [contact us](#contact).

### DCO

Gaga requires all contributors to agree to the DCO. DCO stands for Developer
Certificate of Origin and is maintained by the [Linux
Foundation](https://www.linuxfoundation.org). It is an attestation attached to
every commit made by every developer. All contributions are covered by, and fall
under, the DCO.

<!-- omit in toc -->
#### 5.1.1. Trivial changes

Trivial changes, such as spelling fixes, do not need to be signed.

### Granted rights and copyright assignment

This is covered by the DCO. Contributions are covered by the DCO and do not
require a CLA.

## FAQ

### Why a DCO instead of a CLA?

It's simpler, clearer, and still protects users of Gaga. We believe the DCO more
accurately embodies the principles of open-source. More info can be found here:

- [Gitlab's switch to DCO](https://about.gitlab.com/2017/11/01/gitlab-switches-to-dco-license/)
- [DCO vs CLA](https://opensource.com/article/18/3/cla-vs-dco-whats-difference)

### If I’m contributing while an employee, do I still need my employer to sign something?

Nope! The DCO confirms that you are entitled to submit the code, which assumes
that you are authorized to do so. It treats you like an adult and relies on your
accurate statement about your rights to submit a contribution.

### What if I forgot to sign my commits?

No problem!

```bash
git commit --amend --signoff
```

## Contact

If you have questions about this document or the project as a whole, please
contact us at gaga@madvoid.com.

[urls.create_branch]: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-and-deleting-branches-within-your-repository
[urls.fork_repo]: https://help.github.com/en/github/getting-started-with-github/fork-a-repo
[urls.github_sign_commits]: https://help.github.com/en/github/authenticating-to-github/signing-commits
[urls.submit_pr]: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork
[urls.existing_issues]: https://github.com/madvoidhq/gaga/issues
[urls.new_issue]: https://github.com/madvoidhq/gaga/issues/new
[urls.pull_requests]: https://github.com/madvoidhq/gaga/pulls
