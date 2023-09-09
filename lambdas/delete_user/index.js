const {
  getUserByEmail,
  lambdaResponse
} = require('../common/utils');
const { USERS_TABLE, ERRORS } = require('../common/constants');

const AWS = require('aws-sdk');
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
  try {
    const email = event.queryStringParameters.email;
    if (!email) {
      return lambdaResponse(400, { error: 'Email parameter is required.' });
    }
    return await deleteUser(email);
  } catch (error) {
    console.error('Error:', error);
    return lambdaResponse(500, { error: ERRORS.INTERNAL_SERVER_ERROR });
  }
};

const deleteUser = async (email) => {
  // Ensure the user exists before attempting to delete
  await getUserByEmail(email);

  const params = {
    TableName: USERS_TABLE,
    Key: {
      email: email
    }
  };

  await dynamoDB.delete(params).promise();

  return lambdaResponse(200, { message: 'User deleted successfully' });
};
