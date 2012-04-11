/**
 * @file
 * This file includes functionality needed for tracking
 * a user and her preferneces from the time she signs
 * into the application, through any preference changes,
 * to closing / loging out.
 */

var currentUser = (function () {

  var _user_id = 1;

  return {
    userId: function () {
      return _user_id;
    }
  };
}());
