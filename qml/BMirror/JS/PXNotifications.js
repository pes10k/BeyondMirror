.pragma library

/**
 * @file
 * This library provides a simple notification system for objects,
 * where objects can register themselves to be notified of a certain
 * event, and then other objects can notify all such objects that the
 * event has happened.
 *
 * Objects that register themselves for any kind of notification must
 * implement a "receivedNotification (notification, params)" function,
 * which will be called whenever a signal that the object registered
 * for is sent out.  The params argment is an optional set of parameters
 * that the notifier can send to all listening elements.
 */

/**
 * "Notification Delegate Protocol" Definition
 *
 * Required Methods:
 *
 * - receivedNotification (notification, params)
 *   All objects registered to receieve a given notification will have this
 *   function called on them.  The notification parameter is the name of the
 *   notification that has been signaled.  The params argument is an optional
 *   set of values passed from the signaler to the receivers.
*/

var registry = (function () {

  // Store for all objects that want to be notified.  The keys
  // of this object will be a notification type, and the
  // coresponding value will be an array of objects that
  // want to be notified for that type of event.
  var _registry = {};

  return {
    registerForNotification: function (element, notification) {

      if (_registry[notification] === undefined) {
        _registry[notification] = [];
      }

      if (_registry[notification].indexOf(element) === -1) {

        _registry[notification].push(element);
        return true;

      } else {

        return false;

      }
    },
    unregisterForNotification: function (element, notification) {

      if (_registry[notification] === undefined || _registry[notification].indexOf(element) === -1) {

        return false;

      } else {

        _registry[notification].splice(_registry[notification].indexOf(element), 1);
        return true;
      }
    },
    unregisterForAll: function (element) {

      var key;

      for (key in _registry) {

        if (_registry.hasOwnProperty(key)) {
          this.unregisterForNotification(element, key);
        }
      }
    },
    sendNotification: function (notification, params) {

      var i;

      if (_registry[notification] !== undefined) {

        for (i = 0; i < _registry[notification].length; i += 1) {

          _registry[notification][i].receivedNotification(notification, params);
        }
      }
    }
  }
}());
