import "../../JS/PXApp.js" as App
import "../../JS/PXNotifications.js" as Notifications
import "../"
import QtQuick 1.1

PXRowNext {

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
        textLabel.anchors.left = image.right
        textLabel.anchors.leftMargin = rowNewsImageUrl ? 5 : 0
        textLabel.width = newsRow.width - image.width - 60;
        textLabel.shouldTranslate = false
    }

    id: newsRow

    PXText {
        id: sourceLabel
        height: parent.height * .5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 60
        anchors.left: image.right
        anchors.leftMargin: rowNewsImageUrl ? 5 : 0
        textKey: rowNewsPublisher
        color: "black"
        font.pointSize: 12
        maximumLineCount: 1
        lineHeight: sourceLabel.height
        shouldTranslate: false
    }

    Image {
        id: image
        width: rowNewsImageUrl ? height : 0
        sourceSize.height: 72
        sourceSize.width: 72
        fillMode: Image.PreserveAspectCrop
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        source: rowNewsImageUrl ? rowNewsImageUrl : ""
    }
}
