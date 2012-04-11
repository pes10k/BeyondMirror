import "../"
import QtQuick 1.1

Rectangle {

    // Untranslated text key for the button label
    property string textKey;

    // Unique string identifier for the tab, for use when identifying
    // button presses in the "Tab Delegate Protocol"
    property string tabIdentifier;

    //
    property variant tabDelegate;

    id: tab
    width: 100
    height: 55
    color: "#000000"
    radius: 5
    border.color: "#ffffff"

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {

        }
    }

    PXText {
        id: label
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        textKey: tab.textKey
    }

    states: [
        State {
            name: "DISABLED"

            PropertyChanges {
                target: rectangle1
                color: "#757575"
            }

            PropertyChanges {
                target: label
                color: "#000000"
            }
        }
    ]
}
