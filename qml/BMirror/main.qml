/**
 * @file
 * This QML file defines the root object / container of the entire application.
 * In addition to being the global object that everything gets placed in, it
 * is also responsible for storing and managing state for all the widgets
 * used in the application.
 */
import QtQuick 1.1
import "Views"
import "Views/Widgets"
import "Views/Windows"
import "JS/PXNotifications.js" as Notifications

Rectangle {

    property variant launcherMappings: {
        "news launcher" : newsWidget,
        "twitter launcher" : twitterWidget,
        "stocks launcher" : stocksWidget,
        "health launcher" : healthWidget,
        "video launcher" : videoWidget
    }

    property variant windowMappings: {
        "stock window" : stockWindow,
        "news window" : newsWindow,
        "video window" : videoWindow
    }

    // Implementation of the ""Notification Delegate Protocol"
    function receivedNotification (notification, request) {

        var relevantWindow;

        switch (notification) {

        case "request for window":

            relevantWindow = main.windowMappings[request.window];

            if (relevantWindow) {
                if (!relevantWindow.isOpen()) {
                    relevantWindow.open();
                }

                relevantWindow.setParams(request.params);
            }

            break;
        }
    }

    // Implementation of the "Launcher Delegate Protocol"
    function launcherItemClicked (launcherItem) {

        var relevantWidget = main.launcherMappings[launcherItem.launcherIdentifier];

        if (relevantWidget) {

            if (!relevantWidget.isOpen()) {
                relevantWidget.open();
            }
        }
    }

    // Implementation of "Moving Children Delegate Protocol"
    // Returns true if the new position is valid and should be
    // accepted.  Otherwise, returns false.
    function canChildMoveInParent (child, newCords) {

        if (newCords.x < 0 || newCords.x + child.width > main.width) {

            return false;

        } else if (newCords.y < 0 || newCords.y + child.height > main.height) {

            return false;

        } else {

            return true;
        }
    }

    Component.onCompleted: {
        Notifications.registry.registerForNotification(main, "request for window");
    }

    Component.onDestruction: {
        Notifications.registry.unregisterForAll(main);
    }

    width: 1280
    height: 720
    id: main

    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#ffffff";
        }
        GradientStop {
            position: 1.00;
            color: "#400e0e";
        }
    }

    PXLauncherBar {
        applicationManager: main
        width: 768
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -5
    }

    PXWidgetNews {
        id: newsWidget
        visible: false
        uniqueIdentifier: "news widget"
        width: 300
        height: 300
    }

    PXWidgetTwitter {
        id: twitterWidget
        visible: false
        uniqueIdentifier: "twitter widget"
        width: 300
        height: 400
    }

    PXWidgetStocks {
        id: stocksWidget
        visible: false
        uniqueIdentifier: "stocks widget"
        width: 300
        height: 400
    }

    PXWidgetHealth{
        id: healthWidget
        visible: false
        uniqueIdentifier: "health widget"
        width:600
        height:400
    }

    PXWidgetVideo{
        id: videoWidget
        visible: false
        uniqueIdentifier: "video widget"
        width: 600
        height: 400
    }

    PXWindowStock {
        id: stockWindow
        width: 340
        height: 340
        visible: false
    }

    PXWindowVideo {
        id: videoWindow
        width: 500
        height: 300
        visible: false
    }

    PXWindowNews {
        id: newsWindow
        width: 500
        height: 500
        visible: false
    }
}
