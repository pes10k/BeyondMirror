import QtQuick 1.1
import "../JS/PXNotifications.js" as Notifications
import "../JS/PXLang.js" as Lang

Text {

    /**
      * The untranslated version of the string this element displays.  Whenever
      * the application's language changes, this key will be used to decide
      * what localized string should be used to replace the current one.
      */
    property string textKey;

    /* Notifications Protocol Methods */
    function receivedNotification (notification, params) {
        textElement.text = Lang.translateTerm(textElement.textKey);
    }

    onTextKeyChanged: {
        textElement.text = Lang.translateTerm(textElement.textKey);
    }

    Component.onCompleted: {
        Notifications.registry.registerForNotification(textElement, "language changed");
    }

    Component.onDestruction: {
        Notifications.registry.unregisterForAll(textElement);
    }

    id: textElement;
    font.family: "Futura"
    font.pixelSize: 20
    lineHeight: 28;
    wrapMode: Text.WordWrap;
    maximumLineCount: 2;
    lineHeightMode: Text.FixedHeight;
    verticalAlignment: Text.AlignVCenter;
    horizontalAlignment: Text.AlignLeft;
    elide: Text.ElideRight;
    color: "white"
}
