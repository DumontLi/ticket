module.exports = {
branches: "main",
repositoryUrl: "https://github.com/DumontLi/ticket.git",
plugins: [
'@semantic-release/commit-analyzer', 
'@semantic-release/release-notes-generator', 
'@semantic-release/npm', 
'@semantic-release/github']
}
