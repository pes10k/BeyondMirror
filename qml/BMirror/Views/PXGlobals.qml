import "../JS/PXNotifications.js" as Notifications
import "../JS/Controllers/PXPaneLanguage.js" as LanguageController
import "../JS/PXStorage.js" as Storage

/**
 * @file
 * This file contains references to javascript varaibles, and not any
 * QML elements that should be inserted into documents.
 */
import QtQuick 1.1

QtObject {

    property int currentZIndex: 0;
    property int currentUserId: 0;
    property string currentLangCode: LanguageController.languages.language(currentUserId);
    property int windowRegistery: 0;

    function setCurrentLangCode (newLangCode) {

        currentLangCode = newLangCode;
        Notifications.registry.sendNotification("language changed", {"code" : newLangCode});
    }

    // Whenever the user id changes, we need to update the current language for the application
    onCurrentUserIdChanged: {
        currentLangCode = LanguageController.languages.language(currentUserId);
    }

    // Each window should report that it's going through it's "login" serialization
    // process here.  This is mainly so we can keep track of how many windows are involved
    // in the process
    function loginForWindow (aWindow) {

        windowRegistery += 1;
    }

    // Each window should "report" that it's going through its logout cycle here,
    // so that we can keep track of how many have successfully logged out
    function logoutForWindow (aWindow) {

        windowRegistery -= 1;

        if (windowRegistery === 0) {
            logoutComplete();
        }
    }

    // Cleanup procedures once the logout cycle is complete
    function logoutComplete () {

        currentUserId = -1;

        // Delete any stored settings we have the for the anonymous user
        Storage.deleteAllForUser(-1);
    }
}
