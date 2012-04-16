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
import "JS/PXStorage.js" as Storage

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
        "calendar launcher" : calendarWidget
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

        var relevantWidget;

        if (launcherItem.launcherIdentifier === "log out launcher") {

            Notifications.registry.sendNotification("logout");

        } else {

            relevantWidget = main.launcherMappings[launcherItem.launcherIdentifier];

            if (relevantWidget) {

                if (!relevantWidget.isOpen()) {
                    relevantWidget.open();
                }
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

        // Delete any stored settings we have the for the anonymous user
        Storage.deleteAllForUser(-1);
        Notifications.registry.unregisterForAll(main);
    }

    width: 1280
    height: 720
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#ffffff"
        }

        GradientStop {
            position: 0.970
            color: "#494949"
        }
    }
    id: main


    PXGlobals {
        id: globalVariables
    }

    PXWindowLogin {
        id: loginWindow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height * .75
        width: parent.width * .5
    }

    PXLauncherBar {
        applicationManager: main
        width: 824
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -5
        visible: false
    }

    PXWidgetNews {
        id: newsWidget
        visible: false
        x: 380
        y: 380
        uniqueIdentifier: "news widget"
        width: 300
        height: 300
    }

    PXWidgetTwitter {
        id: twitterWidget
        x: 220
        y: 220
        visible: false
        width: 300
        height: 400
    }

    PXWidgetStocks {
        id: stocksWidget
        visible: false
        width: 340
        height: 340
        uniqueIdentifier: "stocks widget"
        width: 300
        height: 400
    }

    PXWidgetHealth {
        id: healthWidget
        visible: false
        x: 300
        y: 300
        uniqueIdentifier: "health widget"
        width:600
        height:400
    }

    PXWidgetVideo {
        id: videoWidget
        visible: false
        x: 260
        y: 260
        uniqueIdentifier: "video widget"
        width: 400
        height: 400
    }

    PXWindowStock {
        id: stockWindow
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
        x: 220
        y: 220
        width: 560
        height: 500
        visible: false
    }

    PXWindowNews {
        id: newsWindow
        x: 180
        y: 180
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
        visible: false
    }

    PXWidgetWeather {
        id: weatherWidget
        visible: false
        x: 60
        y: 60
        width: 300
        height: 308
    }

    PXWindowSettings {
        id: settingsWindow
        visible: false
        x: 140
        y: 140
        width: 500
        height: 400
    }

    PXWidgetCalendar {
        id: calendarWidget
        visible: false
        x: 100
        y: 100
        width: 500
        height: 500
    }

    PXWindowHelp {
        id: helpWidget
        visible: false
        width: 800
        height: 600
    }
}
