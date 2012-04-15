// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import "../"
import "../Controls"
import QtQuick 1.1
PXWindowWidget {

    //record the current slected tab
    property variant currentTab: sleepTab;

    // Implementation of "Tab Item Delegate Protocol"
    function tabItemClicked (tabItem){
        currentTab.state = "DISABLED"
        switch (tabItem.tabIdentifier) {

        case "weight tab":
            currentTab = weightTab
            break;

        case "sleep tab":
            currentTab = sleepTab
            break;

        case "nutrition tab":
            currentTab = nutritionTab
            break;
        }
    }

    function radioButtonClicked(radioButton){

        if (radioButton.state === 'SELECTED')
            return

        weightInfo.currentRadio.state = "UNSELECTED"
        switch (radioButton.textKey) {
        case "yearly":
            radioButton.state = "SELECTED"
            weightInfo.currentRadio = yearlyRadioButton
            weightInfoChart.source = "../../Images/weight_yearly.png"
            break;
        case "monthly":
            radioButton.state = "SELECTED"
            weightInfo.currentRadio = monthlyRadioButton
            weightInfoChart.source = "../../Images/weight_monthly.png"
            break;
        case "weekly":
            radioButton.state = "SELECTED"
            weightInfo.currentRadio = weeklyRadioButton
            weightInfoChart.source = "../../Images/weight_weekly.png"
            break;
        }
    }

    id: healthWidget
    titleKey: "Health"
    uniqueIdentifier: "health widget window"

    contentView: Rectangle {

        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter

        PXTab {
            id: weightTab
            tabIdentifier: "weight tab"
            anchors.top: parent.top
            anchors.right: sleep.left
            anchors.rightMargin: 60
            textKey: "Weight"
            tabDelegate: healthWidget
            state: "DISABLED"
        }

        PXTab {
            id: sleepTab
            tabIdentifier: "sleep tab"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            textKey: "Sleep"
            tabDelegate: healthWidget
            state: "ABLED"
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
            anchors.top: weightTab.bottom
            anchors.right: parent.right
            anchors.bottom: parent.sleepTab
            anchors.left: parent.left
            anchors.topMargin: 0

            Rectangle {
                id: weightInfo
                anchors.fill: parent
                anchors.horizontalCenter: sleepTab.horizontalCenter
                visible: weight.tabInforVisibility
                property variant currentRadio: monthlyRadioButton

                Image {
                    id:weightInfoChart
                    anchors.left:parent.left
                    source:"../../Images/weight_monthly.png"

                }
                Column {
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: 10

                    PXRadioButton{
                        id:yearlyRadioButton
                        textKey:'yearly'
                        delegate:healthWidget
                    }

                    PXRadioButton{
                        id:monthlyRadioButton
                        textKey:'monthly'
                        delegate:healthWidget
                        state:"SELECTED"
                    }
                    PXRadioButton{
                        id:weeklyRadioButton
                        textKey:'weekly'
                        delegate:healthWidget
                    }
                }
            }

            Rectangle {

                id: nutritionInfo
                anchors.fill: parent
                anchors.top: sleepTab.bottom
                anchors.horizontalCenter: sleepTab.horizontalCenter
                visible: false

                Image {
                    id:nutritionInfoTable
                    anchors.left: parent.left
                    source: "../../Images/nutrition.png"
                }
            }

            Rectangle {
                id: sleepInfo
                anchors.fill: parent
                anchors.top: sleepTab.bottom
                anchors.horizontalCenter: sleepTab.horizontalCenter
                visible: sleepTab.tabInforVisibility
                Image{
                    id:sleepInforChart
                    anchors.left: parent.left
                    source: "../../Images/sleep.png"
                }
            }
        }
    }
}
