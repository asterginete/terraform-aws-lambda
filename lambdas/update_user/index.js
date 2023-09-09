const {
  hashPassword,
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
    const body = JSON.parse(event.body);
    return await updateUser(email, body);
  } catch (error) {
    console.error('Error:', error);
    return lambdaResponse(500, { error: ERRORS.INTERNAL_SERVER_ERROR });
  }
};

const updateUser = async (email, body) => {
  const user = await getUserByEmail(email);

  // If password is being updated, hash the new password
  if (body.password) {
    body.password = await hashPassword(body.password);
  }

  const params = {
    TableName: USERS_TABLE,
    Key: {
      email: email
    },
    UpdateExpression: 'set #name = :name, age = :age, address = :address, phone = :phone, imageLink = :imageLink, linkedinLink = :linkedinLink, githubLink = :githubLink',
    ExpressionAttributeNames: {
      '#name': 'name'  // 'name' is a reserved word in DynamoDB
    },
    ExpressionAttributeValues: {
      ':name': body.name || user.name,
      ':age': body.age || user.age,
      ':address': body.address || user.address,
      ':phone': body.phone || user.phone,
      ':imageLink': body.imageLink || user.imageLink,
      ':linkedinLink': body.linkedinLink || user.linkedinLink,
      ':githubLink': body.githubLink || user.githubLink
    },
    ReturnValues: 'UPDATED_NEW'
  };

  const result = await dynamoDB.update(params).promise();

  return lambdaResponse(200, result.Attributes);
};
