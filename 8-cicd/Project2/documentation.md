# Project 2: Build and push a Docker image with GitHub Actions

## Read first

- [GitHub Actions: Publishing Docker images](https://docs.github.com/en/actions/tutorials/publish-packages/publish-docker-images): Read the Docker Hub example and identify the build and push steps.
- [Docker: Personal access tokens](https://docs.docker.com/security/access-tokens/personal-access-tokens/): Read how to create a token with the access needed to push an image.
- [GitHub Actions: Using secrets](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets): Read how a workflow accesses a repository secret.

## Challenge

Create a basic application, such as `hello-app`, and a Dockerfile for it. Create a GitHub Actions workflow that builds its image and pushes that image to a container registry. Docker Hub is the recommended choice from the lesson; ECR is also allowed.

If you use Docker Hub, create a Docker Hub account and repository, then store a personal access token in GitHub Actions secrets. The workflow should use that secret to authenticate. Do not put the token in the repository or workflow file.

The build and push must happen through GitHub Actions, not through a manual push from your computer. This challenge ends with an image in the registry; deploying or running it in an environment is a separate task.

## Done when

- The repository contains the app, Dockerfile, and image publishing workflow.
- A GitHub Actions run successfully builds and pushes the image.
- You can find the image and its tag in the chosen registry.
- You can explain how the workflow authenticates without exposing the token.
