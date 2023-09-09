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
    const body = JSON.parse(event.body);
    return await createUser(body);
  } catch (error) {
    console.error('Error:', error);
    return lambdaResponse(500, { error: ERRORS.INTERNAL_SERVER_ERROR });
  }
};

const createUser = async (body) => {
  const { email, password, name, age, address, phone, imageLink, linkedinLink, githubLink } = body;

  // Check if user already exists
  try {
    await getUserByEmail(email);
    return lambdaResponse(400, { error: 'User already exists' });
  } catch (error) {
    if (error.message !== ERRORS.USER_NOT_FOUND) {
      return lambdaResponse(500, { error: ERRORS.INTERNAL_SERVER_ERROR });
    }
  }

  const hashedPassword = await hashPassword(password);

  const newUser = {
    email,
    password: hashedPassword,
    name,
    age,
    address,
    phone,
    imageLink,
    linkedinLink,
    githubLink
  };

  const params = {
    TableName: USERS_TABLE,
    Item: newUser
  };

  await dynamoDB.put(params).promise();

  return lambdaResponse(201, { message: 'User created successfully' });
};
