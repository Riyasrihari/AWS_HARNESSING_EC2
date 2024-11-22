CIDR_BLOCK="10.0.0.0/16"
VPC_ID=$(aws ec2 create-vpc --cidr-block $CIDR_BLOCK --query 'Vpc.VpcId' --output text)
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-support "{\"Value\":true}"
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-hostnames "{\"Value\":true}"
echo "VPC Created with ID: $VPC_ID"
VPC_ID="your-vpc-id"  # Replace with your VPC ID
SUBNET_CIDR_BLOCK="10.0.1.0/24"
SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block $SUBNET_CIDR_BLOCK --query 'Subnet.SubnetId' --output text)
echo "Subnet Created with ID: $SUBNET_ID"
AMI_ID="ami-12345678"  # Replace with a valid AMI ID
INSTANCE_TYPE="t2.micro"
KEY_NAME="your-key-pair"  # Replace with your key pair name
SUBNET_ID="your-subnet-id"  # Replace with your subnet ID
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --subnet-id $SUBNET_ID \
    --query 'Instances[0].InstanceId' \
    --output text)
echo "EC2 Instance Launched with ID: $INSTANCE_ID"
VPC_ID="your-vpc-id"  # Replace with your VPC ID
SECURITY_GROUP_NAME="MySecurityGroup"
DESCRIPTION="Security group for SSH access"
MY_IP=$(curl -s ifconfig.me)  # Get your current public IP
SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name $SECURITY_GROUP_NAME --description "$DESCRIPTION" --vpc-id $VPC_ID --query 'GroupId' --output text)
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 22 --cidr $MY_IP/32
echo "Security Group Created with ID: $SECURITY_GROUP_ID"
CIDR_BLOCK="10.0.0.0/16"
SUBNET_CIDR_BLOCK="10.0.1.0/24"
AMI_ID="ami-12345678"  # Replace with a valid AMI ID
INSTANCE_TYPE="t2.micro"
KEY_NAME="your-key-pair"  # Replace with your key pair name
MY_IP=$(curl -s ifconfig.me)
VPC_ID=$(aws ec2 create-vpc --cidr-block $CIDR_BLOCK --query 'Vpc.VpcId' --output text)
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-support "{\"Value\":true}"
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-hostnames "{\"Value\":true}"
echo "VPC Created with ID: $VPC_ID"
SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block $SUBNET_CIDR_BLOCK --query 'Subnet.SubnetId' --output text)
echo "Subnet Created with ID: $SUBNET_ID"
SECURITY_GROUP_NAME="MySecurityGroup"
DESCRIPTION="Security group for SSH access"
SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name $SECURITY_GROUP_NAME --description "$DESCRIPTION" --vpc-id $VPC_ID --query 'GroupId' --output text)
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 22 --cidr $MY_IP/32
echo "Security Group Created with ID: $SECURITY_GROUP_ID"
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --subnet-id $SUBNET_ID \
    --security-group-ids $SECURITY_GROUP_ID \
    --query 'Instances[0].InstanceId' \
    --output text)
echo "EC2 Instance Launched with ID: $INSTANCE_ID"