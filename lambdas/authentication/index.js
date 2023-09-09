const {
  hashPassword,
  comparePassword,
  generateToken,
  getUserByEmail,
  lambdaResponse
} = require('../common/utils');
const { ERRORS } = require('../common/constants');

const AWS = require('aws-sdk');
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
  try {
    const body = JSON.parse(event.body);

    switch (event.path) {
      case '/signup':
        return await signup(body);
      case '/login':
        return await login(body);
      default:
        return lambdaResponse(400, { error: 'Invalid request' });
    }
  } catch (error) {
    console.error('Error:', error);
    return lambdaResponse(500, { error: ERRORS.INTERNAL_SERVER_ERROR });
  }
};

const signup = async (body) => {
  const { email, password, name } = body;

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
    name
  };

  const params = {
    TableName: 'UsersTable',
    Item: newUser
  };

  await dynamoDB.put(params).promise();

  return lambdaResponse(201, { message: 'User created successfully' });
};

const login = async (body) => {
  const { email, password } = body;

  const user = await getUserByEmail(email);

  const isPasswordValid = await comparePassword(password, user.password);
  if (!isPasswordValid) {
    return lambdaResponse(401, { error: ERRORS.INVALID_PASSWORD });
  }

  const token = generateToken(user);

  return lambdaResponse(200, { token });
};
