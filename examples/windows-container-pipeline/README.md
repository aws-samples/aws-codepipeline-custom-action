## AWS CodePipeline for Windows Server containers

This is an example is based on 
[sample ASP.NET Core Docker Sample](https://github.com/dotnet/dotnet-docker/tree/master/samples/aspnetapp) 
and demonstrates how 
[AWS CodePipeline custom actions](https://github.com/aws-samples/aws-codepipeline-custom-action)
can be used to produce Windows Server container images using Amazon EC2 instances.

### Prerequisites
This example relies on custom action resources to be deployed in your AWS account.
Follow [deployment instructions](https://github.com/aws-samples/aws-codepipeline-custom-action#deployment) before proceeding further.

### Deployment
Following command deploys a CloudFormation stack that configures a simple AWS CodePipeline
triggered by S3 object update. The second stage of the pipeline passes S3 artifact to
the custom action that builds Windows Server container image and pushes it into Amazon Elastic Container 
Registry (Amazon ECR) repository.

Deploy the stack using the following command:

> aws cloudformation deploy --capabilities CAPABILITY_NAMED_IAM --template-file .\template.yml --stack-name **{stack-name}** --parameter-overrides CustomActionProviderCategory=**{custom-action-category}** CustomActionProviderName=**{custom-action-name}**  CustomActionProviderVersion=**{custom-action-version}**

Note that you need to provide the following parameters:
 - **{stack-name}** - CloudFormation stack name
 - **{custom-action-category}** - category of the custom action (Build, Deploy, Test, etc. Default category is *Build*)
 - **{custom-action-name}** - name of the custom action (default name is *EC2-CodePipeline-Builder*)
 - **{custom-action-version}** - version of the custom action (1, 2, 3, etc.) 

 ### Test the pipeline
 To test the pipeline, zip contents of the *src* folder into **src.zip** and  upload the file into 
 *SourceBucket*, created by CloudFormation stack. This action triggers CodePipeline and starts build of 
 the Docker image that should eventually be pushed into Amazon ECR.
