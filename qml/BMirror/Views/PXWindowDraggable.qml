import "../JS/PXWindowSerializer.js" as WindowSerializer
import "./Controls"

import QtQuick 1.1

PXWindow {

    // Implementation of Button Delegate Protcol
    function buttonClicked (a_button, a_mouse_event) {

        switch (a_button.buttonIdentifier) {

        case "window-title-bar-close-button":
            windowDraggable.close();
            break;
        }
    }

    // The controller of the this window is expected to give the
    // window a unique identifier, which will be used to referece
    // the window across its life time, including saving it's settings
    // in the database on serialization
    property string uniqueIdentifier;
    property bool isDragging: false;
    property int lastX: 0;
    property int lastY: 0;
    property string titleKey

    Component.onCompleted: {

        if (windowDraggable.contentView) {
            windowDraggable.contentView.parent = windowContent;
        }

        WindowSerializer.unserializeWindow(windowDraggable);
    }

    Component.onDestruction: {
        WindowSerializer.serializeWindow(windowDraggable);
    }

    id: windowDraggable;

    Rectangle {
        id: titleDivider
        height: 1
        color: "#ffffff"
        anchors.top: titlebar.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
    }

    Rectangle {
        id: titlebar
        height: 50
        color: "#00000000"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        PXText {
            id: title
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            horizontalAlignment: Text.AlignHCenter
            textKey: windowDraggable.titleKey
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
        }

        MouseArea {
            id: dragArea
            anchors.fill: parent

            onPressed: {
                windowDraggable.isDragging = true
                windowDraggable.lastX = mouse.x
                windowDraggable.lastY = mouse.y
                windowDraggable.z = WindowSerializer.max_z++;
            }

            onReleased: {
                windowDraggable.isDragging = false
            }

            onPositionChanged: {
                WindowSerializer.repositionWindowOnDrag(windowDraggable, mouse, windowDraggable.parent);
            }
        }
    }

    PXTitleBarButtonClose {

        // Required properies for dependers on the Button Protocol
        buttonDelegate: windowDraggable
        buttonIdentifier: "window-title-bar-close-button"

        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
    }
}
