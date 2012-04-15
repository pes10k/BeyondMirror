import "../JS/PXNotifications.js" as Notifications
import "../JS/Controllers/PXPaneLanguage.js" as LanguageController

/**
 * @file
 * This file contains references to javascript varaibles, and not any
 * QML elements that should be inserted into documents.
 */
import QtQuick 1.1

QtObject {

    property int currentZIndex: 0;
    property int currentUserId: 0;
    property string currentLangCode: LanguageController.languages.language();

    function setCurrentLangCode (newLangCode) {

        currentLangCode = newLangCode;
        Notifications.registry.sendNotification("language changed", {"code" : newLangCode});
    }
}
