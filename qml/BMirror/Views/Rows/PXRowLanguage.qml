import "../../JS/PXNotifications.js" as Notifications
import "../../JS/Controllers/PXPaneLanguage.js" as LanguageController
import QtQuick 1.1

PXRowText {

    Component.onCompleted: {

        var textLabel = row.textLabel();
        textLabel.anchors.left = checkbox.right
        textLabel.anchors.leftMargin = 10
        textLabel.anchors.right = flag.left
        textLabel.anchors.rightMargin = 10
    }

    id: row

    Image {
        id: flag
        width: 70
        height: 35
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        sourceSize.height: 35
        sourceSize.width: 70
        source: "../../Images/flags/" + rowLanguageImage
    }

    Image {
        id: checkbox
        width: height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.top: parent.top
        anchors.topMargin: 1
        anchors.left: parent.left
        anchors.leftMargin: 5
        source: isCurrent ? "../../Images/box-checked.png" : "../../Images/box-unchecked.png"
    }
}
