// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import "../"
import "../Rows"
import "../Controls"
import "../../JS/Controllers/PXWidgetHealth.js" as HealthController
import "../../JS/Controllers/PXController.js" as Controller
import QtQuick 1.1

PXWindowWidget {

    function updateCheckmarks (value) {

        return Controller.updateCheckmarks(healthWidgetConfig.getViewModel(), "rowTextKey", value);
    }

    // Implementation of "Array List Model Delegate Protocol"
    function rowsForModel (model, modelIdentifier) {
        HealthController.addDataSourcesToModel(model);
        updateCheckmarks(HealthController.healthSources.currentSource(globalVariables.currentUserId));
    }

    // Implementation of "Tab Item Delegate Protocol"
    function tabItemClicked (tabItem) {

        var isWeightTab = tabItem === weightTab,
            isSleepTab = tabItem === sleepTab,
            isNutritionTab = tabItem === nutritionTab;

        weightTab.setActiveState(isWeightTab);
        sleepTab.setActiveState(isSleepTab);
        nutritionTab.setActiveState(isNutritionTab);

        weightInfo.visible = isWeightTab;
        sleepInfo.visible = isSleepTab;
        nutritionInfo.visible = isNutritionTab;
    }

    function radioButtonClicked (radioButton){

        if (radioButton.state === 'SELECTED') {
            return;
        }

        weightInfo.currentRadio.state = "UNSELECTED"
        switch (radioButton.textKey) {

        case "yearly":
            radioButton.state = "SELECTED";
            weightInfo.currentRadio = yearlyRadioButton;
            weightInfoChart.source = "../../Images/weight_yearly.png";
            break;

        case "monthly":
            radioButton.state = "SELECTED"
            weightInfo.currentRadio = monthlyRadioButton;
            weightInfoChart.source = "../../Images/weight_monthly.png";
            break;

        case "weekly":
            radioButton.state = "SELECTED";
            weightInfo.currentRadio = weeklyRadioButton;
            weightInfoChart.source = "../../Images/weight_weekly.png";
            break;
        }
    }

    id: healthWidget
    titleKey: "Health"
    uniqueIdentifier: "health widget window"

    configurationView: Rectangle {

        id: configPane
        anchors.fill: parent
        visible: parent.height > 40

        PXText {
            id: dataSourceLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            textKey: "Health Information Data Source"
            color: "black"
            horizontalAlignment: Text.AlignHCenter
        }

        PXListModelArray {
            id: healthWidgetConfig
            arrayResultDelegate: healthWidget
            modelIdentifier: "health source model"
            viewComponent: Component {
                PXRowCheck {
                    function mouseAreaEvent (mouseArea) {
                        HealthController.healthSources.setSource(globalVariables.currentUserId, rowTextKey);
                        healthWidget.updateCheckmarks(rowTextKey);
                    }
                }
            }

            width: 260
            anchors.top: dataSourceLabel.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
        }
    }

    contentView: Rectangle {

        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"

        PXTab {
            id: weightTab
            tabIdentifier: "weight tab"
            anchors.top: parent.top
            anchors.right: sleepTab.left
            anchors.rightMargin: 60
            textKey: "Weight"
            tabDelegate: healthWidget
            state: "ABLED"
        }

        PXTab {
            id: sleepTab
            tabIdentifier: "sleep tab"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            textKey: "Sleep"
            tabDelegate: healthWidget
            state: "DISABLED"
        }

        PXTab {
            id: nutritionTab
            tabIdentifier: "nutrition tab"
            anchors.top: parent.top
            anchors.left: sleepTab.right
            anchors.leftMargin: 60
            textKey: "Nutrition"
            tabDelegate: healthWidget
            state: "DISABLED"
        }

        PXPane {

            id: contentPane
            anchors.top: parent.top
            anchors.topMargin: sleepTab.height
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            Rectangle {

                id: weightInfo
                anchors.fill: parent

                property variant currentRadio: monthlyRadioButton

                Image {
                    id: weightInfoChart
                    anchors.left: parent.left
                    source: "../../Images/weight_monthly.png"
                }

                Column {
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 10

                    PXRadioButton{
                        id: yearlyRadioButton
                        textKey: 'yearly'
                        delegate: healthWidget
                    }

                    PXRadioButton{
                        id: monthlyRadioButton
                        textKey: 'monthly'
                        delegate: healthWidget
                        state: "SELECTED"
                    }

                    PXRadioButton{
                        id: weeklyRadioButton
                        textKey: 'weekly'
                        delegate: healthWidget
                    }
                }
            }

            Rectangle {
                id: sleepInfo
                anchors.fill: parent
                visible: false

                Image {
                    id: sleepInforChart
                    anchors.left: parent.left
                    source: "../../Images/sleep.png"
                }
            }

            Rectangle {

                id: nutritionInfo
                anchors.fill: parent
                visible: false

                Image {
                    id: nutritionInfoTable
                    anchors.left: parent.left
                    source: "../../Images/nutrition.png"
                }
            }
        }
    }
}
