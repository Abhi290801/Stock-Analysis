# Deploying to Railway

Follow these steps to deploy the Stock Advisor application to Railway:

## Prerequisites

1. Create a [Railway account](https://railway.app/)
2. Install Railway CLI (optional):
   ```
   npm i -g @railway/cli
   ```

## Deployment Steps

### Option 1: Deploy via Railway Dashboard (Easiest)

1. Push your code to GitHub:
   ```
   git add .
   git commit -m "Prepare for Railway deployment"
   git push
   ```

2. Go to [Railway Dashboard](https://railway.app/dashboard)
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Connect your GitHub account if not already connected
   - Select your repository
   - Click "Deploy Now"

3. Set Environment Variables:
   - In your project dashboard, go to "Variables" tab
   - Add the following variables:
     - `ALPHA_KEY`: Your Alpha Vantage API key
     - `OPENAI_KEY`: Your OpenAI API key

4. Your app will be deployed automatically. Click "Generate Domain" to get a public URL.

### Option 2: Deploy via Railway CLI

1. Login to Railway:
   ```
   railway login
   ```

2. Link your project:
   ```
   railway init
   ```

3. Deploy the application:
   ```
   railway up
   ```

4. Set environment variables:
   ```
   railway variables set ALPHA_KEY=your_alpha_vantage_key
   railway variables set OPENAI_KEY=your_openai_key
   ```

5. Generate a domain:
   ```
   railway domain
   ```

## Troubleshooting

- **Build Failures**: Check the build logs in Railway dashboard
- **Application Errors**: Check the logs in Railway dashboard
- **Memory Issues**: Upgrade to a paid plan if you need more resources