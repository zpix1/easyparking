# EasyParking

Easy app for easy parking

# Rules

## Git flow

1. Create a branch from main in format `<your_id>/#<issue-id>-<issue-description>` ex: `ibaksheev/#8267-repo-template`.
2. Develop a feature / fix a bug in that branch
3. Create a merge request on GitHub, wait for review
4. LGTM, merged!

## Linter and prettier

- Linter is enabled in all JS apps. Follow recommendations!
- Install prettier vscode plugin to fix all problems on save

# Modules

## easyparking-frontend

Svelte frontend app for both easyparking-backend and easyparking-image-worker

## easyparking-backend

Express.js app to store and manage users

## easyparking-ml

Python ML code to find cars in images

## easyparking-pooler

Elixir app to load images from cameras
