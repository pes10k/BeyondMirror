import "../../JS/PXApp.js" as App
import "../../JS/PXNotifications.js" as Notifications
import "../"
import QtQuick 1.1

PXRowText {

    function mouseAreaEvent () {
        Notifications.registry.sendNotification("request for window", {
            "window" : "news window",
            "params" : {
                "title" : rowTextKey,
                "url" : rowNewsUrl
            }
        });
    }

    Component.onCompleted: {
        var textLabel = newsRow.textLabel();
        textLabel.font.pointSize = 12;
        textLabel.anchors.top = newsRow.top;
        textLabel.maximumLineCount = 1;
        textLabel.width = newsRow.width - 60;
    }

    id: newsRow

    PXText {
        id: sourceLabel
        height: parent.height * .5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 60
        anchors.left: parent.left
        anchors.leftMargin: 5
        textKey: rowNewsPublisher
        color: "black"
        font.pointSize: 12
        maximumLineCount: 1
    }
}
