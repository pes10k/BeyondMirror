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
        "video launcher" : videoWidget,
        "clock launcher" : clockWidget,
        "weather launcher" : weatherWidget,
        "settings launcher" : settingsWindow,
        "help launcher": helpWidget,
        //"log out launcher": logOutWidget
    }

    property variant windowMappings: {
        "stock window" : stockWindow,
        "news window" : newsWindow,
        "video window" : videoWindow,
        "twitter window" : twitterWindow
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

    function launcherInitilized (launcherItem) {

        var relevantWidget = main.launcherMappings[launcherItem.launcherIdentifier];

        if (relevantWidget) {
            if (relevantWidget.isOpen()) {
                launcherItem.state = "PRESSED"
            }
        }
    }

    // Implementation of "Moving Children Delegate Protocol"
    // Adjusts the coordinates of the child to not exceed
    // the parent's bounds, if needed
    function moveInParent (child, newCords) {

        var adjusted_cords = {"x" : newCords.x, "y": newCords.y};

        if (newCords.x < 0) {

            adjusted_cords.x = 0;

        } else if (newCords.x + child.width > main.width) {

            adjusted_cords.x = main.width - child.width;

        }

        if (newCords.y < 0) {

            adjusted_cords.y = 0;

        } else if (newCords.y + child.height > main.height) {

            adjusted_cords.y = main.height - child.height

        }

        return adjusted_cords;
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

    PXGlobals {
        id: globalVariables
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

    PXWidgetHealth {
        id: healthWidget
        visible: false
        uniqueIdentifier: "health widget"
        width:600
        height:400
    }

    PXWidgetVideo {
        id: videoWidget
        visible: false
        uniqueIdentifier: "video widget"
        width: 400
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

    PXWindowTwitter {
        id: twitterWindow
        width: 560
        height: 500
        visible: false
    }

    PXWindowNews {
        id: newsWindow
        width: 500
        height: 500
        visible: false
    }

    PXWidgetClock {
        id: clockWidget
        x: 20
        y: 20
        width: 200
        height: 120
    }

    PXWidgetWeather {
        id: weatherWidget
        visible: false
        width: 300
        height: 308
    }

    PXWindowSettings {
        id: settingsWindow
        visible: false
        width: 500
        height: 400
    }

    PXWindowHelp {
        id: helpWidget
        visible: false
        width: 800
        height: 600

    }
}
