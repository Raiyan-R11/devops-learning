# Git Notes

## Add Changes to an Already-Pushed Commit

To include uncommitted changes in the latest commit, amend it and push the updated history.

> **Note:** This rewrites Git history and requires a force push. Coordinate with others if the branch is shared.

```bash
git add .
git commit --amend --no-edit
git push --force-with-lease
```
