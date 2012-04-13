import "../JS/PXWindowSerializer.js" as WindowSerializer
import "./Controls"
import QtQuick 1.1

PXWindowDraggable {

    property variant configurationView;

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

    Component.onCompleted: {

        if (windowDraggable.contentView) {
            windowDraggable.contentView.parent = windowContent;
        }

        if (windowDraggable.configurationView) {
            windowDraggable.configurationView.parent = configurationPanel;
        }

        WindowSerializer.unserializeWindow(windowDraggable);
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
        color: "black"
        border.width: 2
        border.color: "black"
        radius: 2
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 50
        z: 2
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
