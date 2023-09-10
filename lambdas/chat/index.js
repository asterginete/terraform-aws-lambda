const {
  lambdaResponse
} = require('../common/utils');
const { CHAT_MESSAGES_TABLE, ERRORS } = require('../common/constants');
const uuid = require('uuid');

const AWS = require('aws-sdk');
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
  try {
    switch (event.httpMethod) {
      case 'POST':
        return await sendMessage(JSON.parse(event.body));
      case 'GET':
        return await listMessages(event.queryStringParameters);
      default:
        return lambdaResponse(400, { error: 'Invalid request method' });
    }
  } catch (error) {
    console.error('Error:', error);
    return lambdaResponse(500, { error: ERRORS.INTERNAL_SERVER_ERROR });
  }
};

const sendMessage = async (body) => {
  const { sender, recipient, message } = body;

  if (!sender || !recipient || !message) {
    return lambdaResponse(400, { error: 'Missing required fields' });
  }

  const chatMessage = {
    id: uuid.v4(),
    sender,
    recipient,
    message,
    timestamp: Date.now()
  };

  const params = {
    TableName: CHAT_MESSAGES_TABLE,
    Item: chatMessage
  };

  await dynamoDB.put(params).promise();

  return lambdaResponse(201, { message: 'Message sent successfully' });
};

const listMessages = async (queryParams) => {
  const { sender, recipient } = queryParams;

  if (!sender || !recipient) {
    return lambdaResponse(400, { error: 'Sender and recipient are required' });
  }

  const params = {
    TableName: CHAT_MESSAGES_TABLE,
    FilterExpression: '(sender = :sender AND recipient = :recipient) OR (sender = :recipient AND recipient = :sender)',
    ExpressionAttributeValues: {
      ':sender': sender,
      ':recipient': recipient
    }
  };

  const result = await dynamoDB.scan(params).promise();

  return lambdaResponse(200, result.Items);
};
