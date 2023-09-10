const {
  lambdaResponse
} = require('../common/utils');
const { FEEDBACK_TABLE, ERRORS } = require('../common/constants');

const AWS = require('aws-sdk');
const dynamoDB = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
  try {
    const body = JSON.parse(event.body);
    return await storeFeedback(body);
  } catch (error) {
    console.error('Error:', error);
    return lambdaResponse(500, { error: ERRORS.INTERNAL_SERVER_ERROR });
  }
};

const storeFeedback = async (body) => {
  const { userId, feedbackText } = body;

  if (!userId || !feedbackText) {
    return lambdaResponse(400, { error: 'Missing required fields' });
  }

  const feedback = {
    userId,
    feedbackText,
    timestamp: Date.now()
  };

  const params = {
    TableName: FEEDBACK_TABLE,
    Item: feedback
  };

  await dynamoDB.put(params).promise();

  return lambdaResponse(201, { message: 'Feedback stored successfully' });
};
