// DynamoDB Table Names
const USERS_TABLE = 'UsersTable';
const CHAT_MESSAGES_TABLE = 'ChatMessagesTable';
const FEEDBACK_TABLE = 'FeedbackTable';
const NOTIFICATIONS_TABLE = 'NotificationsTable';
const USER_SESSIONS_TABLE = 'UserSessionsTable';

// SNS Topic ARNs (You'd typically fetch these from environment variables or SSM)
const USER_NOTIFICATIONS_TOPIC_ARN = process.env.USER_NOTIFICATIONS_TOPIC_ARN;

// JWT Secret (You'd typically fetch this from environment variables or SSM)
const JWT_SECRET = process.env.JWT_SECRET;

// Error Messages
const ERRORS = {
  USER_NOT_FOUND: 'User not found.',
  INVALID_PASSWORD: 'Invalid password.',
  TOKEN_EXPIRED: 'Token has expired.',
  TOKEN_INVALID: 'Invalid token.',
  ACCESS_DENIED: 'Access denied.',
  INTERNAL_SERVER_ERROR: 'Internal server error.'
};

module.exports = {
  USERS_TABLE,
  CHAT_MESSAGES_TABLE,
  FEEDBACK_TABLE,
  NOTIFICATIONS_TABLE,
  USER_SESSIONS_TABLE,
  USER_NOTIFICATIONS_TOPIC_ARN,
  JWT_SECRET,
  ERRORS
};
