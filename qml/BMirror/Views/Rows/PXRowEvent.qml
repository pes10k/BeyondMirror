import "../../JS/PXNotifications.js" as Notifications
import "../../JS/Controllers/PXPaneLanguage.js" as LanguageController
import "../"
import QtQuick 1.1

PXRowText {

    Component.onCompleted: {

        var textLabel = row.textLabel();
        textLabel.width = parent.width * .7
        textLabel.maximumLineCount = 1
        textLabel.elide = Text.ElideRight
        textLabel.verticalAlignment = Text.AlignVCenter
    }

    id: row

    PXText {
        textKey: rowEventStart
        anchors.right: parent.right
        anchors.rightMargin: 5
        color: "black";
        width: parent.width * .3
        horizontalAlignment: Text.AlignRight
        maximumLineCount: 1
        elide: Text.ElideLeft
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
