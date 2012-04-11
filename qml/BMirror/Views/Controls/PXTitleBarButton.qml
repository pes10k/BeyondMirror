import QtQuick 1.1

Rectangle {

    // Referenece to another object that will handle what happens when this
    // button is clicked.  This object should implement the button delegate
    // protocol
    property variant buttonDelegate;
    property string buttonIdentifier;

    id: closeButton
    width: 40
    height: 40
    color: "#ffffff"
    radius: 20

    MouseArea {
        id: closeArea
        anchors.fill: parent

        onClicked: {
            buttonDelegate.buttonClicked(closeButton, mouse);
        }
    }
}
