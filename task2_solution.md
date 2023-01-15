## Task 2 - Deploy on Cloud

### Approach
We can deploy the containerized application in multiple ways as following: 
 - Deploy individual _**t2.micro**_ EC2 instances and install docker and docker compose to build the application the same way we did using on-premise hardware in Task #1. 
 - Make use of AWS EKS (Elastic Kubernetes Service), whose architecture will be very similar to regular kuberbetes service as would be seeing in Task #3 (coming ahead).
 
 We will go ahead with AWS EKS for our solution and use _**t2.micro**_ EC2 instances as our worker nodes because it is a free tier instance _(atleast for new users for one year)_
 
 In order to make our deployment public, we can have a static IP (Elastic IP) assigned to our instance serving nginx. But for accessing the app, users would have to always the remember the IP _(which is not happening)_ and is not a proper solution. So, we would have to come up with something that allows us to create a public domain. And AWS Route 53 would be a right option to go with.
 
 We can have a domain name registered using AWS Route 53 (simple policy) which can then forward the request to our application. There is another way to architect the AWS solution here. Instead of running nginx server, we could make use of AWS ALB (Application Load Balancer) to balance the load.

### Prerequisites
- We will require AWS account (for sure)
- Dockerizing our application
- AWS ECR
- AWS IAM
- AWS EKS
- kubectl

### Flow
We need AWS Account on which we would create an IAM group and user with appropriate permissions (IAM policy) and IAM roles for AWS EKS (recommended). 

Install AWS CLI to administrate the cluster from our local machine.
```sh
aws configure
``` 
command will allow you to configure your aws account on your local machine.
	
Since we already have the container framework ready from Task #1, we would require to push our images to AWS ECR _(Elastic Container Registry)_.

We would create a private repository on ECS and it is straightforward to create one. A new repository URI will be generated after creating the repository. This URI will be used to tag the local image and then can be further pushed to the ECR.
>For ex. `we have 3 local images (from Task 1) named: assignment-backend, assignment-frontend, assignment-nginx and these will be tagged with the repository URI`
```sh
docker tag assignment-backend <repo-uri>:<tag>
docker push <repo-uri>:<tag>
```
Now, we have our images ready in AWS. We will be creating an AWS EKS cluster. For creating a cluster, we would need to assign correct roles to the EKS to allow access to other AWS services by EKS. For ex. would need to add 'AmazonEKSClusterPolicy' in the Cluster Service Role.

After creating an EKS cluster (preferrably through management console), we would add Worker Nodes by creating a nodegroup. This will also require attaching certain policies like 'AmazonEC2ContainerRegistryReadOnly', 'AmazonEKS_CNI_Policy', etc. to the nodegroup.

Once the cluster and nodegroup are running, we should create/update kubeconfig file to be able to access aws eks cluster through our local machine terminal.

Now, we can deploy the app the same way we deploy in a kubernetes cluster. 
For ex. `kubectl apply -f 'app-deployment.yaml' to deploy manifest to our EKS cluster.

### Architecture 
User client --> Route 53 --> ALB --> EKS or EC2 (running applciations) (these EC2 instances will be in a private subnet with their security groups configured to take only traffic from ALB).

- This would enhance the security of our app and would prevent it from any external access. Only ALB can be allowed to have inbound traffic from anywhere.

