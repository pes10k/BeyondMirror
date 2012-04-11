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

Rectangle {

    property variant launcherMappings: {
        "news launcher" : newsWidget,
                "twitter launcher" : twitterWidget,
                "stocks launcher" : stocksWidget,
                "health launcher" : healthWidget
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

    PXWindowDraggable {
        uniqueIdentifier: "test window"
        titleKey: "Window"
        x: 100
        y: 100
        width: 300
        height: 300
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
        width: 300
        height: 400
    }
}
