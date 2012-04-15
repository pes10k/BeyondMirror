import "../../JS/PXApp.js" as App
import "../../JS/Controllers/PXController.js" as GenericController
import "../../JS/Controllers/PXWindowWeather.js" as WeatherController
import "../../JS/PXNotifications.js" as Notifications
import "../../Views/Rows"
import "../Controls"
import "../"
import QtQuick 1.1

PXWindowWidget {

    // Implementation of "Checkbox Delegate Protocol"
    function checkboxClicked (checkbox) {

        // If someone is checking an already checked checkbox,
        // do nothing.  We're using these things as radio buttons
        // here...
        if (!checkbox.isChecked) {

            checkbox.checked(true);

            if (checkbox === weatherFDegreesCheck) {

                WeatherController.weather.setDegreeType(globalVariables.currentUserId, "f");
                weatherCDegreesCheck.checked(false);

            } else {

                WeatherController.weather.setDegreeType(globalVariables.currentUserId, "c");
                weatherFDegreesCheck.checked(false);

            }

            weatherModel.refresh();
        }
    }

    // Implementation of the "Array List Model Delegate Protocol"
    function rowsForModel (model, modelIdentifier) {

        if (modelIdentifier === "weather view model") {
            WeatherController.addWeatherToModel(globalVariables.currentUserId, model);
        }
    }

    uniqueIdentifier: "weather widget"
    titleKey: "Weather"
    id: weatherWindow

    contentView: PXListModelArray {
        id: weatherModel
        modelIdentifier: "weather view model"
        arrayResultDelegate: weatherWindow
        viewComponent: Component {
            PXRowWeather {}
        }
    }

    configurationView: Rectangle {
        height: parent.height
        id: weatherConfigurationPane
        anchors.fill: parent

        PXCheckbox {
            id: weatherFDegreesCheck
            height: parent.height > 50 ? 50 : 0
            visible: height > 10
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 10
            textboxIndentifier: "weather f degrees checkbox"
            textKey: "Use Fahrenheit Scale"
            checkboxDelegate: weatherWindow
            isChecked: WeatherController.weather.degreeType(globalVariables.currentUserId) === "f";
        }

        PXCheckbox {
            id: weatherCDegreesCheck
            height: parent.height > 120 ? 50 : 0
            visible: height > 10

            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top: weatherFDegreesCheck.bottom
            anchors.topMargin: 10

            textboxIndentifier: "weather c degrees checkbox"
            textKey: "Use Celsius Scale"
            checkboxDelegate: weatherWindow
            isChecked: WeatherController.weather.degreeType(globalVariables.currentUserId) === "c";
        }
    }
}
