const {
  getUserByEmail,
  lambdaResponse
} = require('../common/utils');
const { ERRORS } = require('../common/constants');

const AWS = require('aws-sdk');
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
  try {
    const email = event.queryStringParameters.email;
    if (!email) {
      return lambdaResponse(400, { error: 'Email parameter is required.' });
    }
    return await readUser(email);
  } catch (error) {
    console.error('Error:', error);
    return lambdaResponse(500, { error: ERRORS.INTERNAL_SERVER_ERROR });
  }
};

const readUser = async (email) => {
  const user = await getUserByEmail(email);

  // Remove sensitive data before returning
  delete user.password;

  return lambdaResponse(200, user);
};
