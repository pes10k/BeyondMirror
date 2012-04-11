import "../JS/PXWindowSerializer.js" as WindowSerializer
import "./Controls"
import QtQuick 1.1

PXWindowDraggable {


    // Implementation of Button Delegate Protcol
    function buttonClicked (a_button, a_mouse_event) {

        switch (a_button.buttonIdentifier) {

        case "window-title-bar-close-button":
            windowDraggable.close();
            break;

        case "window-title-bar-configure-button":
            if (windowDraggable.state === "CONFIGURING") {

                windowDraggable.state = "DEFAULT"
            }
            else {

                windowDraggable.state = "CONFIGURING"
            }
        }
    }

    id: windowDraggable
    state: "DEFAULT"

    PXTitleBarButtonConfig {

        // Required properies for dependers on the Button Protocol
        buttonDelegate: windowDraggable
        buttonIdentifier: "window-title-bar-configure-button"

        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
    }

    Rectangle {
        id: configurationPanel
        color: "#dcffffff"
        border.width: 2
        border.color: "#0a646464"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 50
    }

    Rectangle {
        id: windowContent
        color: "transparent"
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 55
        anchors.fill: parent
    }

    states: [
        State {
            name: "CONFIGURING"

            PropertyChanges {
                target: configurationPanel
                height: parent.height - 60
            }
        }
    ]

    transitions: [
        Transition {
            from: "DEFAULT"
            to: "CONFIGURING"
            PropertyAnimation {
                properties: "height";
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "CONFIGURING"
            to: "DEFAULT"
            PropertyAnimation {
                properties: "height";
                easing.type: Easing.InOutQuad
            }
        }
    ]
}
