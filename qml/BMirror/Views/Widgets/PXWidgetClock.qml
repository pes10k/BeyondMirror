import "../../JS/PXApp.js" as App
import "../../JS/Controllers/PXController.js" as GenericController
import "../../JS/PXNotifications.js" as Notifications
import "../../JS/Controllers/PXWidgetClock.js" as ClockController
import "../../Views/Rows"
import "../Controls"
import "../"
import QtQuick 1.1

PXWindowWidget {

    // Implements the "Checkbox Delegate Protocol"
    function checkboxClicked (checkbox) {

        checkbox.checked(!checkbox.isChecked);
        ClockController.clock.setConfigOptions("hours_24", checkbox.isChecked);
    }

    uniqueIdentifier: "clock widget"
    titleKey: "Clock"
    id: clockWidget

    contentView: Rectangle {

        color: "transparent"
        anchors.fill: parent

        PXText {
            anchors.fill: parent
            id: timeLabel
            shouldTranslate: false
            textKey: ""
            color: "white"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 30
            lineHeight: 34
            maximumLineCount: 1
        }
    }

    configurationView: Rectangle {
        anchors.fill: parent
        color: "green"
        PXCheckbox {
            isChecked: ClockController.clock.is24HourTime();
            anchors.fill: parent
            textboxIndentifier: "clock AM/PM checkbox"
            textKey: "24 Hr Time?"
            checkboxDelegate: clockWidget
        }
    }

     Timer {
         interval: 1000
         running: true
         repeat: true
         onTriggered: {
            timeLabel.textKey = ClockController.clock.currentFormattedTime();
        }
     }
}
