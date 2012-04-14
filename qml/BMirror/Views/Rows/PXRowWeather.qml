import "../../JS/PXApp.js" as App
import "../../JS/PXNotifications.js" as Notifications
import "../"
import QtQuick 1.1

PXRowText {

    // We don't do anything on clicking a weather row, so just swallow the
    // event here with a empty function
    function mouseAreaEvent () {}

    Component.onCompleted: {
        var textLabel = row.textLabel();
        textLabel.maximumLineCount = 1;
        textLabel.width = parent.width * .5
    }

    id: row

    Rectangle {
        id: imageContainer
        height: 41
        width: 41
        anchors.left: parent.left
        anchors.leftMargin: parent.width * .5 + 10
        anchors.verticalCenter: parent.verticalCenter
        color: "#ffffff"
        border.color: "#000000"

        Image {
            id: image
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            sourceSize.height: 40
            sourceSize.width: 40
            fillMode: Image.PreserveAspectCrop
            source: rowWeatherImage
        }
    }

    PXText {
        id: degreesLabel
        textKey: rowWeatherDegrees + "°"
        color: "black"
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: imageContainer.right
        anchors.leftMargin: 20
        shouldTranslate: false
    }
}
