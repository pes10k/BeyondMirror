import "../JS/PXWindowSerializer.js" as WindowSerializer
import "../JS/PXNotifications.js" as Notifications
import "./Controls"

import QtQuick 1.1

PXWindow {

    // Implements "Notification Delegate Protocol"
    function receivedNotification (notification, params) {
        if (notification === "logout") {
            windowDraggable.logout();
        } else if (notification === "login") {
            windowDraggable.login();
        }
    }

    // Implementation of Button Delegate Protcol
    function buttonClicked (a_button, a_mouse_event) {

        switch (a_button.buttonIdentifier) {

        case "window-title-bar-close-button":
            windowDraggable.close();
            break;
        }
    }

    function close () {
        windowDraggable.state = "CLOSING"
    }

    function open () {
        windowDraggable.z = globalVariables.currentZIndex++;
        windowDraggable.state = "APPEARING"
    }

    function logout () {
        WindowSerializer.serializeWindow(globalVariables.currentUserId, windowDraggable, function (isSuccess) {
            if (isSuccess) {
                windowDraggable.close();
                globalVariables.logoutForWindow(windowDraggable);
            }
        });
    }

    function login () {

        WindowSerializer.unserializeWindow(globalVariables.currentUserId, windowDraggable, function (isSuccess) {

            globalVariables.loginForWindow(windowDraggable);
            if (windowDraggable.visible) {
                windowDraggable.open();
            }
        });
    }

    // Instances of PXWindowDraggable should define PXWindowDraggable.contentView
    // as the view that should be placed in the main section of the window, when
    // the window is in "main" / "viewing" mode.
    property variant contentView

    // The controller of the this window is expected to give the
    // window a unique identifier, which will be used to referece
    // the window across its life time, including saving it's settings
    // in the database on serialization
    property string uniqueIdentifier
    property bool isDragging: false
    property int lastX: 0
    property int lastY: 0
    property string titleKey;

    // Implementing windows can set this to be true to make sure that they
    // start out closed whenever the application is opened
    property bool beginClosed: true

    Component.onCompleted: {

        if (windowDraggable.contentView) {
            windowDraggable.contentView.parent = windowContent;
        }

        windowDraggable.z = globalVariables.currentZIndex++;

        Notifications.registry.registerForNotification(windowDraggable, "logout");
        Notifications.registry.registerForNotification(windowDraggable, "login");
    }

    Component.onDestruction: {
        WindowSerializer.serializeWindow(globalVariables.currentUserId, windowDraggable);
        Notifications.registry.unregisterForAll(windowDraggable);
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
            anchors.rightMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 40
            maximumLineCount: 1
            elide: Text.ElideMiddle
        }

        MouseArea {
            id: dragArea
            anchors.fill: parent

            onPressed: {
                windowDraggable.isDragging = true
                windowDraggable.lastX = mouse.x
                windowDraggable.lastY = mouse.y
                windowDraggable.z = globalVariables.currentZIndex++;
            }

            onReleased: {
                windowDraggable.isDragging = false
            }

            onPositionChanged: {
                WindowSerializer.repositionWindowOnDrag(windowDraggable, mouse, windowDraggable.parent);
            }
        }
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
