# Deploying Stock Advisor to AWS Amplify

This guide explains how to deploy the Stock Advisor application to AWS Amplify.

## Prerequisites

1. AWS Account
2. AWS CLI installed and configured
3. Amplify CLI installed (`npm install -g @aws-amplify/cli`)
4. Git repository for your project

## Deployment Steps

### 1. Initialize Amplify

```bash
# Initialize Amplify in your project
amplify init

# Follow the prompts:
# - Enter a name for the project
# - Choose your default editor
# - Choose the type of app (backend only)
# - Choose the AWS profile to use
```

### 2. Add Hosting

```bash
# Add hosting to your Amplify project
amplify add hosting

# Choose "Hosting with Amplify Console"
# Choose "Continuous deployment"
```

### 3. Push to Git Repository

```bash
# Commit all changes
git add .
git commit -m "Prepare for Amplify deployment"
git push
```

### 4. Connect Repository in Amplify Console

1. Go to the [AWS Amplify Console](https://console.aws.amazon.com/amplify/home)
2. Choose "Connect app"
3. Select your Git provider
4. Select your repository and branch
5. Configure build settings:
   - Use the existing `amplify.yml` file
   - Add environment variables:
     - `ALPHA_KEY`: Your Alpha Vantage API key
     - `OPENAI_KEY`: Your OpenAI API key

### 5. Advanced Settings

1. In the Amplify Console, go to "App settings" > "Build settings"
2. Ensure the build specification is using your `amplify.yml` file
3. Add any additional environment variables needed

### 6. Deploy

1. Click "Save and deploy"
2. Wait for the build and deployment to complete

### 7. Access Your Application

Once deployment is complete, you can access your application at the URL provided by Amplify.

## Troubleshooting

- **Build Failures**: Check the build logs in the Amplify Console
- **Runtime Errors**: Check CloudWatch Logs
- **Database Issues**: Ensure your RDS instance (if using) is properly configured and accessible

## Additional Resources

- [AWS Amplify Documentation](https://docs.aws.amazon.com/amplify/)
- [Spring Boot on AWS](https://aws.amazon.com/blogs/devops/deploying-a-spring-boot-application-on-aws-using-aws-elastic-beanstalk/)