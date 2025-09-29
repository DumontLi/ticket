# 1- install semantic release in your local env
npm install --save-dev semantic-release
npm install --save-dev semantic-release @semantic-release/git @semantic-release/github -D


# 2- create a config file (release.config.js) in the project with the contents below:
release.config.js: with content below
module.exports = {
branches: "main",
repositoryUrl: "https://github.com/DumontLi/s3-backend-repo.git",
plugins: [
'@semantic-release/commit-analyzer', 
'@semantic-release/release-notes-generator', 
'@semantic-release/npm', 
'@semantic-release/github']
}


# 3- Add your project to the repo: to download the plugins
git add .

# 4- commit your project to the repo using conventional commits. your commit message should start with:
    fix:                              for a patch version
    feat:                             for a minor version 
    BREAKING CHANGE:                  for a major version

# 5- Add step in the CI workflow:

.github/workflows/release.yaml:

name: release workflow

on: [workflow_dispatch]   # manually trigger the wf - dispatch manually

jobs:
  release:
    permission:
      contents: write
      issues: write
      pull-requests: write
    runs-on: ubuntu latest
    steps:
      - name: checkout
        uses: actions/checkout@v3
      - name: release
        run: npx semantic-release  # the command that is going to run to look for a release
        env: 
          GITHUB_TOKEN: ${{secrets.GITHUB_TOKEN}}
   