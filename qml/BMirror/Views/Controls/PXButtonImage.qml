import "../"
import QtQuick 1.1

Rectangle {

    property string buttonIdentifier;
    property bool isBackButton: false;
    property alias textKey: buttonLabel.textKey;
    property alias source: nextImage.source;

    id: button
    width: 120
    height: 50
    radius: 5
    color: "white"
    border.width: 1
    border.color: "black"

    PXText {
        id: buttonLabel
        color: "#000000"
        horizontalAlignment: Text.AlignLeft
        textKey: "Next"
        anchors.left: isBackButton ? nextImage.right : parent.left
        anchors.leftMargin: 10
        anchors.right: isBackButton ? parent.right : nextImage.left
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: nextImage
        height: 18
        anchors.right: isBackButton ? undefined : parent.right
        anchors.rightMargin: 10
        anchors.left: isBackButton ? parent.left : undefined
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: isBackButton ? "../../Images/backwards-icon.png" : "../../Images/forward-icon.png"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (button.onClick) {
                button.onClick(button);
            }
        }

        onPressed: {
            button.state = "pressed"
        }

        onCanceled: {
            button.state = "default"
        }

        onReleased: {
            button.state = "default"
        }
    }
    states: [
        State {
            name: "pressed"

            PropertyChanges {
                target: button
                color: "#c0c0c0"
            }
        }
    ]
}
