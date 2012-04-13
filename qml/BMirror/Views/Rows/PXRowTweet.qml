import "../../JS/PXApp.js" as App
import "../../JS/PXNotifications.js" as Notifications
import "../"
import QtQuick 1.1

PXRowNext {

    function mouseAreaEvent () {
        Notifications.registry.sendNotification("request for window", {
            "window" : "twitter window",
            "params" : {
                "title" : rowTwitterUser,
                "url" : rowTwitterUrl
            }
        });
    }

    Component.onCompleted: {
        var textLabel = tweetRow.textLabel();
        textLabel.font.pointSize = 12;
        textLabel.anchors.top = tweetRow.top;
        textLabel.anchors.left = image.right
        textLabel.maximumLineCount = 1;
        textLabel.width = tweetRow.width - image.width - 60;
    }

    id: tweetRow

    PXText {
        id: creditsText
        height: (parent.height * .5) - 5
        width: parent.width - image.width - 60
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.left: image.right
        anchors.leftMargin: 5
        font.pointSize: 12
        maximumLineCount: 1
        lineHeight: height
        textKey: "@" + rowTwitterUser + " – " + (rowTwitterDate ? (new Date(rowTwitterDate)).toDateString() : "")
        color: "black"
    }

    Image {
        id: image
        width: height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        source: rowTwitterImageUrl
    }
}
