var Joi = require('joi');
module.exports = {
  sex      : Joi.string().email().required().max(10),
  phone    : Joi.string().email().required().max(15),
  email    : Joi.string().email().required().max(254), // Required
  password : Joi.string().required().min(6).max(100),  // minimum length 6 characters]
  name     : Joi.string().optional().max(100),
  id       : Joi.any().forbidden()
};
