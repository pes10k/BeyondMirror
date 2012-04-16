import "../"
import "../Controls"
import "../Rows"
import "../../JS/PXNotifications.js" as Notifications
import "../../JS/PXApp.js" as App
import "../../JS/PXStorage.js" as Storage
import QtQuick 1.1

PXPane {

    id: accountPane
    anchors.fill: parent

    PXText {
        id: accountLabel
        color: "#000000"
        textKey: "Do you wish to save your account for future use?  Doing so will allow BeyondMirror to keep your settings and preferences for next time."
        anchors.rightMargin: 40
        anchors.leftMargin: 40
        anchors.bottomMargin: 40
        anchors.topMargin: 11
        anchors.fill: parent
        maximumLineCount: 100
    }
}
