Qt.include("JSON2.js");

/**
 * Return an instantiated database connection to the local SQLite
 * instance, and create any needed tables if they don't exist.
 * This is implemented as a closure to make sure that we only go
 * to the trouble of creating a single database connection for the
 * entire lifetime of the program, instead of on each database call.
 * The closure allows for doing this w/o using a global variable.
 *
 * @return object
 *   An instantiated DB connection, using the Qt Javascript
 *   Offline Storage API
 */
var dbConnection = (function () {

    var connection = false;

    return function () {

        if (!connection) {

            connection = openDatabaseSync("beyondmirror", "1.0", "StorageDatabase", 100000);

            connection.transaction(function (tx) {

             // If this is the first time we've opened the DB, check to make sure
             // the needed table is in place (we just want a simple key value pair table
             // for each user)
             tx.executeSql('CREATE TABLE IF NOT EXISTS settings(user_id INT, setting TEXT, value TEXT)');
          });
        }

        return connection;
    };
}());

// Deletes all settings for a user.  Used to clear out all content for a temporary user.
var deleteAllForUser = function (user_id, callback) {

    dbConnection().transaction(function (tx) {

       var rs = tx.executeSql("DELETE FROM settings WHERE user_id = ?", [user_id]);

        if (callback) {
            callback( !! rs.rowsAffected);
        }
    });
};

// Returns a boolean description of whether there is any data stored for the given user
var dataExistsForUser = function (user_id, callback) {

    dbConnection().transaction(function (tx) {

       var rs = tx.executeSql("SELECT * FROM settings WHERE user_id = ? AND setting = 'language settings' LIMIT 1", [user_id]);

       callback(rs.rows.length === 1);
    });
};

// Returns a boolean description of whether there is any data stored for any user in the system.
// The result is returned via callback (true or false).
var dataExistsForAnyUser = function (callback) {

    dbConnection().transaction(function (tx) {

       var rs = tx.executeSql("SELECT * FROM settings WHERE setting = 'language settings' LIMIT 1", []);

       callback(rs.rows.length === 1);
    });
}

/**
 * Returns a value stored in the app's SQLite instance.  Values
 * are automatically deserialized before being returned,
 * so this function will return back something equivilent to what
 * it was given with setValueForKey
 * a
 *
 * @param int user_id
 *   The unique identififer for an application user
 * @param string key
 *   The identifier for a property saved with setValueForKey
 *
 * @return object|boolean
 *   Either the deserialized version of what was saved with the
 *   same key with setValueForKey, or false if no such value exists.
 */
var valueForKey = function (user_id, key) {

    var result;

    dbConnection().transaction(function (tx) {

       var rs = tx.executeSql("SELECT value FROM settings WHERE setting = ? AND user_id = ? LIMIT 1", [key, user_id]);

       if (rs.rows.length === 0) {

           result = false;
       }
       else {

           result = rs.rows.item(0).value ? JSON.parse(rs.rows.item(0).value) : false;
       }
    })

    return result
};

/**
 * Stores a value in the database, and saves it with a corresponding unique
 * key.  Like a hashtable, calling this function multiple times with the same
 * key, but with different values, will cause previous values to be overwritten.
 * This function automatically serializes values being stored as JSON strings,
 * so any collection of objects, strings, arrays and integers can be stored.
 *
 * @param object value
 *   A value to be stored in the database
 * @param int user_id
 *   The unique identififer for an application user
 * @param string key
 *   A unique key for this value, to later be used to look the value up with
 * @param funciton callback
 *   An optional callback function to execute after the update has been performed
 *
 * @return null
 *   Calling functions should rely on the given callback to determine what should
 *   be done
 */
var setValueForKey = function (user_id, value, key, callback) {

    var rs;

    dbConnection().transaction(function (tx) {

        var row_exits_rs;

        // First check to see if there is already a value in place for this
        // user / key pair
        row_exits_rs = tx.executeSql("SELECT value FROM settings WHERE user_id = ? AND setting = ? LIMIT 1", [user_id, key]);

        // If a row does exist, we just need to update it.  Otherwise,
        // insert a new row, to replace the existing one
        if (row_exits_rs.rows.length === 1) {

          rs = tx.executeSql("UPDATE settings SET value = ? WHERE user_id = ? AND setting = ?", [JSON.stringify(value), user_id, key]);

        } else {

          rs = tx.executeSql("INSERT INTO settings VALUES (?, ?, ?)", [user_id, key, JSON.stringify(value)]);
        }

        if (callback) {
            callback( !! rs.rowsAffected);
        }
    });
};

/**
 * Deletes a value from storage, corresponding to the given key.
 *
 * @param int user_id
 *   The unique identififer for an application user
 * @param string key
 *   The key the value was paired with when saved using setValueForKey
 *
 * @return boolean
 *   True if any changes were made to the database.  Otherwise, false.
 */
var deleteKey = function (user_id, key) {

    var rs;

    dbConnection().transaction(function (tx) {

       rs = tx.executeSql("DELETE FROM settings WHERE user_id = ? AND setting = ?", [user_id, key]);
    });

    return !! rs.rowsAffected;
};
