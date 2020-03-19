# How to setup
---
## Prereqs
A jenkins sever with a role is created in the source account and applied to an EC2 instance, and that is where this terraform is applied from.

## Steps

1.  Replace the Account ID in `./policies/target_trust_policy.json` with the Account ID of the source account.

2.  Login to the Target Account in the aws cli (or enable the target account profile)

3.  Run the following command to create the role in the target account:
    ```bash
    aws iam create-role --role-name terraform-policy-manager --assume-role-policy-document file://policies/target_trust_policy.json
    ```

4.  Run the following command to attach the policy to the role created in step `3.`.
    ```bash
    aws iam put-role-policy --role-name terraform-policy-manager --policy-name terraform-policy-manager-policy --policy-document file://policies/target_policy.json
    ```

5.  Add the following permission to the EC2 instance role in:
    ```
    {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Resource": "<arn-of-role-in-target-account>"
    }
    ```

6. Update the `main.tf` file in the root of this repo to assume the `<arn-of-role-in-target-account>`



