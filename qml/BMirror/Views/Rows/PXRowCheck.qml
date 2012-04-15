import "../../JS/PXNotifications.js" as Notifications
import "../../JS/Controllers/PXPaneLanguage.js" as LanguageController
import QtQuick 1.1

PXRowText {

    Component.onCompleted: {

        var textLabel = row.textLabel();
        textLabel.anchors.left = checkbox.right;
        textLabel.anchors.leftMargin = 5;
        textLabel.anchors.right = row.right;
        textLabel.anchors.rightMargin = 5;
    }

    id: row

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
