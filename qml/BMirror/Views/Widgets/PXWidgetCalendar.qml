import "../../JS/PXApp.js" as App
import "../../JS/Controllers/PXController.js" as GenericController
import "../../JS/Controllers/PXWidgetCalendar.js" as CalendarController
import "../../JS/PXNotifications.js" as Notifications
import "../../Views/Rows"
import "../Controls"
import "../Rows"
import "../"
import QtQuick 1.1
import QtWebKit 1.0

PXWindowWidget {

    // "Array List Model Delegate Protocol" Definition
    function rowsForModel (model, modelIdentifier) {

        var auth_code;

        if (modelIdentifier === "calendar model") {

            CalendarController.calendarFetcher(globalVariables.currentUserId, function (results, url) {

                var i = 0;

                if (results.data) {

                    for (i; i < results.data.length; i++) {

                        model.append({"rowTextKey" : results.data[i].title});
                    }
                }
            });
        }
    }

    // Implementation of "Notification Delegate Protocol"
    function receivedNotification (notification, params) {

        if (notification === "logout") {

            calendarWidget.logout();

        } else if (notification === "login") {

            calendarWidget.login();
        }
    }

    function configurationViewClosed () {

        calendarModel.refresh();
    }

    Component.onCompleted: {
        Notifications.registry.registerForNotification(calendarWidget, "logout");
        Notifications.registry.registerForNotification(calendarWidget, "login");
    }

    id: calendarWidget
    titleKey: "Calendar"
    uniqueIdentifier: "calendar widget";

    contentView: Rectangle {
        anchors.fill: parent

        PXListModelArray {
            id: calendarModel
            arrayResultDelegate: calendarWidget
            viewComponent: Component {
                PXRowText {}
            }

            modelIdentifier: "calendar model"
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            anchors.fill: parent
        }
    }

    configurationView: Rectangle {

        anchors.fill: parent
        color: "black";

        PXWebView {
            id: configWebView
            anchors.fill: parent
            url: "http://snyderp.org/calendar.php?user_id=" + globalVariables.currentUserId;
        }
    }
}
