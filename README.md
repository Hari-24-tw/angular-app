# GitHub Actions Workflows for Angular Application

This repository contains two GitHub Actions workflows for building and deploying an Angular application. The workflows are defined in the following files:
- `angular-app.yml`
- `angular-app-custom.yml`

## Workflow: `angular-app.yml`

### Description
This workflow is triggered on push and pull request events to the `main` branch. It builds the Angular application for multiple environments (dev, qa, prod) and uploads the build artifacts.

### Features
- **Trigger Events**:
  - `push` to `main` branch
  - `pull_request` to `main` branch


- **Job: build**:
  - **Runs-on**: `ubuntu-24.04`
  - **Matrix Strategy**: Builds the application for multiple environments specified in the matrix (`dev`, `qa`, `prod`).
  - **Steps**:
    - **Checkout repository**: Uses `actions/checkout@v2` to check out the repository code.
    - **Set up Node.js**: Uses `actions/setup-node@v2` to set up Node.js version `22.12.0`.
    - **Install Angular CLI**: Runs `npm install -g @angular/cli` to globally install the Angular CLI.
    - **Install dependencies**: Runs `npm install` to install the project's dependencies.
    - **Build Angular app**: Runs `ng build --progress=false -c=${{ matrix.environment }} --output-path=dist${{ matrix.environment }} --base-href=/` to build the Angular app for the specified environment.
    - **Upload artifact**: Uses `actions/upload-artifact@v4` to upload the build artifact for the specified environment.

- **Job: deploy**:
  - **Runs-on**: `ubuntu-24.04`
  - **Needs**: `build` job
  - **Matrix Strategy**: Deploys the application for the same environments specified in the build job.
  - **Steps**:
    - **Deploy to environment**: Runs a placeholder command to simulate deployment for the specified environment.

### Pipeline Execution Steps
1. Push code to the `main` branch or create a pull request to the `main` branch.
2. The workflow is triggered and the `build` job starts.
3. The `build` job runs the build steps for each environment in parallel.
4. The build artifacts are uploaded for each environment.
5. The `deploy` job starts after the `build` job completes.
6. The `deploy` job runs the deployment steps for each environment in parallel.

## Workflow: `angular-app-custom.yml`

### Description
This workflow is triggered manually using the `workflow_dispatch` event. It builds and deploys the Angular application for environments specified in the input.

### Features
- **Trigger Event**:
  - `workflow_dispatch` with inputs:
    - `environments`: Comma-separated list of environments to deploy to (default: `["dev"]`).
    - `sha`: Commit SHA to deploy (required).

- **Job: build**:
  - **Runs-on**: `ubuntu-24.04`
  - **Matrix Strategy**: Builds the application for environments specified in the input.
  - **Steps**:
    - **Checkout repository**: Uses `actions/checkout@v2` to check out the repository code at the specified commit SHA.
    - **Set up Node.js**: Uses `actions/setup-node@v2` to set up Node.js version `22.12.0`.
    - **Install Angular CLI**: Runs `npm install -g @angular/cli` to globally install the Angular CLI.
    - **Install dependencies**: Runs `npm install` to install the project's dependencies.
    - **Build Angular app**: Runs `ng build --progress=false -c=${{ matrix.environment }} --output-path=dist${{ matrix.environment }} --base-href=/` to build the Angular app for the specified environment.
    - **Upload artifact**: Uses `actions/upload-artifact@v4` to upload the build artifact for the specified environment.

- **Job: deploy**:
  - **Runs-on**: `ubuntu-24.04`
  - **Needs**: `build` job
  - **Matrix Strategy**: Deploys the application for the same environments specified in the build job.
  - **Steps**:
    - **Deploy to environment**: Runs a placeholder command to simulate deployment for the specified environment.

### Pipeline Execution Steps
1. Trigger the workflow manually from the GitHub Actions tab.
2. Provide the required inputs (`environments` and `sha`).
3. The `build` job starts and runs the build steps for each specified environment in parallel.
4. The build artifacts are uploaded for each environment.
5. The `deploy` job starts after the `build` job completes.
6. The `deploy` job runs the deployment steps for each environment in parallel.

## Conclusion
These workflows provide a robust CI/CD pipeline for building and deploying an Angular application to multiple environments. The `angular-app.yml` workflow is triggered automatically on code changes, while the `angular-app-custom.yml` workflow allows for manual triggering with specific inputs.

---
### Useful Links for GitHub Actions

- [Understanding GitHub Actions](https://docs.github.com/en/actions/about-github-actions/understanding-github-actions): Learn the basics of GitHub Actions.
- [Writing and Customizing GitHub Actions Workflows](https://docs.github.com/en/actions/writing-workflows): Guide on creating and modifying workflows.
- [Reusing Workflows](https://docs.github.com/en/actions/sharing-automations/reusing-workflows): Instructions on how to reuse workflows.
- [Events that Trigger Workflows](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows): Details on events that can trigger workflows.
- [Sharing Automations](https://docs.github.com/en/actions/sharing-automations): Information on sharing automation scripts.
- [Managing Environments for Deployment](https://docs.github.com/en/actions/managing-workflow-runs-and-deployments/managing-deployments/managing-environments-for-deployment): Guide on managing deployment environments.
- [Running Variations of Jobs in a Workflow](https://docs.github.com/en/actions/writing-workflows/choosing-what-your-workflow-does/running-variations-of-jobs-in-a-workflow): Learn how to run different job variations in a workflow.