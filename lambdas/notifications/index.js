const {
  sendNotification,
  lambdaResponse
} = require('../common/utils');
const { ERRORS, SNS_TOPIC_ARN } = require('../common/constants');

const AWS = require('aws-sdk');
const SNS = new AWS.SNS();

exports.handler = async (event) => {
  try {
    const body = JSON.parse(event.body);
    return await sendUserNotification(body);
  } catch (error) {
    console.error('Error:', error);
    return lambdaResponse(500, { error: ERRORS.INTERNAL_SERVER_ERROR });
  }
};

const sendUserNotification = async (body) => {
  const { userId, message } = body;

  if (!userId || !message) {
    return lambdaResponse(400, { error: 'Missing required fields' });
  }

  // In a real-world scenario, you might fetch the user's contact details (like phone number or email) based on the userId.
  // For simplicity, we'll assume the userId is an email address and send the notification directly.

  await sendNotification(message, SNS_TOPIC_ARN);

  return lambdaResponse(200, { message: 'Notification sent successfully' });
};
