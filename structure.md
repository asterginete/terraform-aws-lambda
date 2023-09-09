terraform-aws-lambda/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── dynamodb.tf
│   ├── lambda.tf
│   ├── apigateway.tf
│   ├── iam.tf
│   ├── ssm.tf
│   └── notifications.tf
│
├── lambdas/
│   ├── common/
│   │   ├── utils.js
│   │   └── constants.js
│   │
│   ├── authentication/
│   │   ├── index.js
│   │   └── package.json
│   │
│   ├── create_user/
│   │   ├── index.js
│   │   └── package.json
│   │
│   ├── read_user/
│   │   ├── index.js
│   │   └── package.json
│   │
│   ├── update_user/
│   │   ├── index.js
│   │   └── package.json
│   │
│   ├── delete_user/
│   │   ├── index.js
│   │   └── package.json
│   │
│   ├── chat/
│   │   ├── index.js
│   │   └── package.json
│   │
│   ├── notifications/
│   │   ├── index.js
│   │   └── package.json
│   │
│   └── feedback/
│       ├── index.js
│       └── package.json
│
├── frontend/
│   ├── src/
│   ├── public/
│   ├── package.json
│   └── README.md
│
├── mobile_app/ (optional)
│   ├── src/
│   ├── assets/
│   ├── package.json
│   └── README.md
│
└── README.md
