# User Management and Feedback System

This application provides a comprehensive solution for user management, chat, notifications, and feedback collection. It's built using AWS services, primarily Lambda, DynamoDB, and API Gateway, and is deployed using Terraform.

## Features

1. **User Management**: CRUD operations for user data.
2. **Authentication**: Secure user authentication.
3. **Chat**: Real-time chat functionality.
4. **Notifications**: Sending notifications to users.
5. **Feedback**: Collecting and storing user feedback.

## Directory Structure

```
.
├── lambdas/
│   ├── authentication/
│   ├── chat/
│   ├── create_user/
│   ├── delete_user/
│   ├── feedback/
│   ├── notifications/
│   ├── read_user/
│   ├── update_user/
│   └── common/
│       ├── constants.js
│       └── utils.js
└── terraform/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── dynamodb.tf
    ├── iam.tf
    ├── apigateway.tf
    ├── ssm.tf
    └── notifications.tf
```

## Setup

### Prerequisites

- AWS CLI configured with appropriate permissions.
- Terraform installed.
- Node.js and npm installed.

### Deployment

1. **Initialize Terraform**:
   ```bash
   cd terraform
   terraform init
   ```

2. **Apply Terraform Configuration**:
   ```bash
   terraform apply
   ```

3. **Install Lambda Dependencies**:
   Navigate to each lambda directory and install the required npm packages.
   ```bash
   cd lambdas/authentication
   npm install
   ```

   Repeat for other lambda directories as needed.

4. **Deploy Lambdas**:
   Use AWS CLI or AWS Management Console to deploy the Lambda functions.

### Usage

After deployment, you can use the provided API Gateway endpoint to interact with the system. Here are some example operations:

- **Create User**:
  `POST /users`

- **Read User**:
  `GET /users?email=user@example.com`

- **Update User**:
  `PUT /users?email=user@example.com`

- **Delete User**:
  `DELETE /users?email=user@example.com`

- **Send Chat Message**:
  `POST /chat`

- **List Chat Messages**:
  `GET /chat?sender=user1@example.com&recipient=user2@example.com`

- **Send Notification**:
  `POST /notifications`

- **Submit Feedback**:
  `POST /feedback`

## Libraries Used

- **aws-sdk**: AWS SDK for JavaScript in Node.js.
- **bcrypt**: Library for hashing and salting passwords.
- **uuid**: For generating unique identifiers.
- **jsonwebtoken**: For generating and verifying JWT tokens.

## Contributing

If you'd like to contribute, please fork the repository and use a feature branch. Pull requests are warmly welcome.

## Licensing

The code in this project is licensed under ISC license.
