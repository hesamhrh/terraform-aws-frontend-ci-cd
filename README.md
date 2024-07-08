Sure! Here's the updated description including the additional instructions:

---

# AWS Terraform Frontend Deployment CI/CD

This repository provides a template for deploying a front-end application to AWS using Terraform and GitHub Actions. The setup automates the deployment process to an S3 bucket and invalidates the CloudFront cache to ensure your updates are live immediately.

## Features

- **Infrastructure as Code (IaC):** Use Terraform to provision and manage AWS resources including an S3 bucket and CloudFront distribution.
- **Continuous Deployment (CD):** Automate the deployment of your front-end application with GitHub Actions.
- **AWS Integration:** Seamlessly deploy your application to AWS S3 and CloudFront.
- **Cache Invalidation:** Automatically invalidate CloudFront cache to reflect the latest changes.

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/aws-terraform-frontend-deployment-ci-cd.git
   cd aws-terraform-frontend-deployment-ci-cd
   ```

2. **Configure AWS Credentials:**
   Set up the following secrets in your GitHub repository:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_REGION`
   - `AWS_S3_BUCKET`
   - `AWS_CLOUDFRONT_DISTRIBUTION_ID`

3. **Initialize and Apply Terraform:**
   Navigate to the `terraform` folder and initialize Terraform:
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```

4. **Modify Terraform variables:**
   Edit the `variables.tf` file in the `terraform` folder to set your desired AWS region and S3 bucket name.

5. **Deploy:**
   Push your changes to the `main` branch to trigger the GitHub Actions workflow and deploy your application.

## Directory Structure

- `.github/workflows/deploy.yml` - GitHub Actions workflow for CI/CD pipeline.
- `terraform/variables.tf` - Terraform variables configuration.
- `terraform/main.tf` - Terraform main configuration file.

## License

This project is licensed under the MIT License.

---

By following the steps in this repository, you can easily set up a continuous deployment pipeline for your front-end application on AWS.
