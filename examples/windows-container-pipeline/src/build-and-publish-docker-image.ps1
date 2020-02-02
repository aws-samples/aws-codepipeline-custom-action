param (
    [string]$accountId,
    [string]$region,
    [string]$repositoryName
)

trap
{
  Write-Output $_
  exit 1
} 

# Authenticate with ECR
Write-Output "Authenticate with ECR..."
Invoke-Expression -Command (Get-ECRLoginCommand).Command

# Build and push the image
Write-Output "Building $repositoryName..."
docker build -t $repositoryName . 

Write-Output "Push $repositoryName to ECR..."
docker push $repositoryName

return $LASTEXITCODE