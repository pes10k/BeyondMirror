import "../../JS/PXNotifications.js" as Notifications
import "../../JS/Controllers/PXPaneLanguage.js" as LanguageController
import QtQuick 1.1

PXRowText {

    Component.onCompleted: {

        var textLabel = row.textLabel();
        textLabel.anchors.left = checkbox.right
        textLabel.anchors.leftMargin = 10
        textLabel.anchors.rightMargin = 10
    }

    id: row
    property variant checkbox: checkbox

    Image {
        id: checkbox
        width: height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.left: parent.left
        anchors.leftMargin: 5
        source: "../../Images/box-unchecked.png"
    }
}
