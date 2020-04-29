#!/bin/bash

LIST=$(aws ec2 describe-instances  --region us-west-2 --filters "Name=tag:Name,Values=ansible-node" --query "Reservations[*].Instances[*].[PrivateIpAddress]" --output text | xargs  | sed 's/[^ ][^ ]*/"&"/g' | sed -e 's/ /,/g')
echo "{
    \"group\": {
        \"hosts\": [ $LIST ]
    }
}"
