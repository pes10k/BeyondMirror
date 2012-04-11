Qt.include("JSON2.js");

/**
 * @file
 * This file provides a simplified, JS interface for fetching
 * JSON data from a remote service, unserializing it,
 * and feeding it back to a QML defined object, using a provided
 * callback / anonymous function.
 *
 * @param string souce
 *   A URL that returns a JSON string
 * @aram element
 */
var jsonSource = function (source, element) {

  return {
      element: element,
      source: source,

      /**
       * Begins an asynchronous call to the webservice
       * to retrieve the JSON string.  Since the call is
       * asynchronous, this function doesn't directly return anything.
       * Instead, the caller should provide a callback function, which
       * will be called when results have been retrieved.
       *
       * @param function callback
       *   An anonymous function that will be called with two arguments
       *   once results have been fetched from the server.
       *     - rows (array): An array of rows described by the returned
       *                     JSON string
       *     - elm (object): The previously set ListModel object, that
       *                     should received or be populated with the
       *                     returned data.
       */
      fetch: function (callback) {

          var request = new XMLHttpRequest(),
              that = this;

          request.open("GET", that.source, true);
          request.onreadystatechange = function (event) {

              var result, rows = [], i;

              if (request.readyState === 4) {

                  if (request.status === 200) {

                      result = JSON.parse(request.responseText);

                      for (i = 0; i < result.nodes.length; i++) {
                          rows.push(result.nodes[i].node);
                      }

                      callback(rows, that.element);
                  }
              };
          }

          request.send(null);
      }
  };
};
