import "../"
import QtQuick 1.1

Rectangle {

    // Unique identifier for the button, so that the button delegate can
    // respond to presses
    property string buttonIdentifier;

    // Reference to an element that implements the "Button Delegate Protocol"
    property variant buttonDelegate;

    // Untranslated text key for the button label
    property string textKey;

    id: button
    width: 100
    height: 40
    color: "#000000"
    radius: 5
    border.color: "#ffffff"

    PXText {
        id: label
        anchors.fill: parent
        textKey: button.textKey
        color: "white"
        horizontalAlignment: Text.AlignHCenter
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {

            if (buttonDelegate.buttonPressed) {
                buttonDelegate.buttonPressed(button);
            }
        }
    }
}
