/**
 * @file
 * This QML file defines the container that all launcher items (the buttons
 * that are pressed to launch widgets and applications) sit in.
 */
import "../JS/PXNotifications.js" as Notifications
import "../Views/Controls"
import QtQuick 1.1

Rectangle {

    // Implementation of the "Notification Delegate Protocol"
    function receivedNotification (notification, params) {

        switch (notification) {

        case "window closed":

            var relatedLauncher = launcherBar.widgetMappings[params.window.uniqueIdentifier];

            if (relatedLauncher) {

                relatedLauncher.state = "DEFAULT";
            }
        }
    }

    // Provides a "static" mapping between widget identifiers
    // and their respective laucher
    property variant widgetMappings: {
        "news widget" : newsLauncher,
                "stocks widget" : stockLauncher,
                "twitter widget" : twitterLauncher,
    }

    property variant applicationManager;

    Component.onCompleted: {

        // Register for notifications for everytime a window has closed, so
        // we can update the corresponding launcher item's state (disabled, etc.)
        // as needed.
        Notifications.registry.registerForNotification(launcherBar, "window closed");
    }

    Component.onDestruction: {

        // Just to keep things tidy, remove ourselves from all notifications when
        // the tool bar closes.  This is probably unnecessary, since the toolbar will
        // only close when the application closes, but is a good practice for other
        // elements to follow.
        Notifications.registry.unregisterForAll(launcherBar);
    }

    id: launcherBar
    height: 115
    color: "transparent"

    Rectangle {
        id: launcherBackground
        height: parent.height
        color: "#000000"
        radius: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -25
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        border.color: "#ffffff"
    }

    Rectangle {
        id: launcherItemsContainer
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        color: "transparent"

        PXLauncher {
            id: newsLauncher
            launcherIdentifier: "news launcher"
            launcherDelegate: applicationManager
            textKey: "News"
            launcherImage: "../../Images/news2.png"
        }

        PXLauncher {
            id: twitterLauncher
            launcherIdentifier: "twitter launcher"
            launcherDelegate: applicationManager
            textKey: "Twitter"
            anchors.left: newsLauncher.right
            anchors.leftMargin: 10
            launcherImage: "../../Images/twitter.png"
        }

        PXLauncher {
            id: stockLauncher
            launcherIdentifier: "stocks launcher"
            launcherDelegate: applicationManager
            textKey: "Stocks"
            anchors.left: twitterLauncher.right
            anchors.leftMargin: 10
            launcherImage: "../../Images/stock2.png"
        }
    }
}
