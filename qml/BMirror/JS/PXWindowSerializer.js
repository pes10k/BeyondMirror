/**
 * @file
 * This library / file includes functionality for (re)storing
 * settings for windows when they're created and when they're
 * destory, so that they can have persistant settings between
 * sessions.
 */

Qt.include("PXStorage.js");
Qt.include("PXApp.js");

/**
 * Userializes a window and populates relevant properties
 * from stored versions, where available.  Currently
 * this just restores the window's position to where it
 * was when it was last closed.
 *
 * @param int user_id
 *   Unique identifier for a user in the system
 * @param object pxwindow
 *   A PXWindow instance that may have properites / state stored
 *   in the database
 *
 * @return bool
 *   True if some state was restored to the window.  Otherwise, false.
 */
function unserializeWindow (user_id, pxwindow, callback) {

    var window_properties = valueForKey(user_id, pxwindow.uniqueIdentifier),
        result = false;

    if (window_properties) {

        pxwindow.x = window_properties.x;
        pxwindow.y = window_properties.y;
        pxwindow.visible = window_properties.visible;

        result = true;
    }

    if (callback) {
        callback(result);
    }
}

/**
 * Attempts to store window state / configuration for a window across
 * sessions.  Currently just attempts to store the window's X / Y
 * cords
 *
 * @param int user_id
 *   Unique identifier for a user in the system
 * @param object pxwindow
 *   A PXWindow instance that should have properites / state stored
 *   in the database.  This window must have a unique identifier
 *   property set, to track the window's settings
 *
 * @return bool
 *   Returns true if some properties for the window were set.  Otherwise,
 *   returns false.
 */
function serializeWindow (user_id, pxwindow, callback) {

    var params = {};

    // If we don't have a unique identifier for the window, we won't
    // be able to save anything retreivable anyway, so bail out now
    if (!pxwindow.uniqueIdentifier) {

        callback(false);

    } else {

        params.x = pxwindow.x;
        params.y = pxwindow.y;
        params.visible = pxwindow.visible && pxwindow.beginClosed !== true;

        setValueForKey(user_id, params, pxwindow.uniqueIdentifier, callback);
    }
}

/**
 * Handles repositioning a window on drag.  This is done
 * by manipulating the given window (pxwindow) within its parent's
 * layout, so it won't work on heavily / incorrectly nested elements.
 *
 * @param object pxwindow
 *   A PXWindowDraggable instance, to be repositioned on drag
 * @param object mouseEvent
 *   The MouseEvent object provided to mouse related signals in QT/QML
 * @param object parentWindow
 *   The window / container that the given pxwindow lives in.  If provided,
 *   and if it implements the "Moving Children Delegate Protocol", its asked
 *   to see if the new possible coordinates are valid
 *
 * @return boolean
 *   Returns true if the window was repositioned, otherwise false
 */
function repositionWindowOnDrag (pxwindow, mouseEvent, parentWindow) {

    var new_cords;

    if (pxwindow.isDragging !== true) {

        return false;

    } else {

        // Calculate the offset of the mouse pointer in the
        // draggable window against the entire, parent window
        new_cords = {
            "x" : pxwindow.x + mouseEvent.x - pxwindow.lastX,
            "y" : pxwindow.y + mouseEvent.y - pxwindow.lastY
        }

        if (parentWindow && parentWindow.moveInParent) {

            new_cords = parentWindow.moveInParent(pxwindow, new_cords);
        }

        pxwindow.x = new_cords.x;
        pxwindow.y = new_cords.y;

        return true;
    }
}
