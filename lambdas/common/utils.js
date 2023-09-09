const AWS = require('aws-sdk');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { USERS_TABLE, JWT_SECRET, ERRORS } = require('./constants');

const dynamoDB = new AWS.DynamoDB.DocumentClient();
const SNS = new AWS.SNS();

// Utility function to hash a password
const hashPassword = async (password) => {
  return await bcrypt.hash(password, 10);
};

// Utility function to compare a password with its hash
const comparePassword = async (password, hash) => {
  return await bcrypt.compare(password, hash);
};

// Utility function to generate a JWT token
const generateToken = (user) => {
  return jwt.sign({ email: user.email, role: user.role }, JWT_SECRET, {
    expiresIn: '1h'
  });
};

// Utility function to send a notification
const sendNotification = async (message, topicArn) => {
  const params = {
    Message: message,
    TopicArn: topicArn
  };
  return await SNS.publish(params).promise();
};

// Utility function to fetch user by email
const getUserByEmail = async (email) => {
  const params = {
    TableName: USERS_TABLE,
    Key: {
      email: email
    }
  };

  const result = await dynamoDB.get(params).promise();
  if (!result.Item) {
    throw new Error(ERRORS.USER_NOT_FOUND);
  }

  return result.Item;
};

// Utility function to handle Lambda responses
const lambdaResponse = (statusCode, body) => {
  return {
    statusCode: statusCode,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    },
    body: JSON.stringify(body)
  };
};

module.exports = {
  hashPassword,
  comparePassword,
  generateToken,
  sendNotification,
  getUserByEmail,
  lambdaResponse
};
