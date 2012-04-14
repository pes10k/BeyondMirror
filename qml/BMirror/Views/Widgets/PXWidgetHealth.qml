// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import "../"
import "../Controls"
import QtQuick 1.1
PXWindowWidget {

    function tabItemClicked(tabItem){
        //console.log(sleepInfor.width+":"+sleepInfor.height)
        currentTab.state = "DISABLED"
        switch (tabItem.tabIdentifier){
        case "weight tab":
            currentTab = weight
            break;
        case "sleep tab":
            currentTab = sleep
            break;
        case "nutrition tab":
            currentTab = nutrition
            break;
        }
    }

    function radioButtonClicked(radioButton){

        if (radioButton.state === 'SELECTED')
            return

        weightInfor.currentRadio.state="UNSELECTED"
        switch(radioButton.textKey){
        case "yearly":
            radioButton.state = "SELECTED"
            weightInfor.currentRadio = yearlyRadioButton
            weightInforChart.source = "../../Images/weight_yearly.png"
            break;
        case "monthly":
            radioButton.state = "SELECTED"
            weightInfor.currentRadio = monthlyRadioButton
            weightInforChart.source = "../../Images/weight_monthly.png"
            break;
        case "weekly":
            radioButton.state = "SELECTED"
            weightInfor.currentRadio = weeklyRadioButton
            weightInforChart.source = "../../Images/weight_weekly.png"
            break;
        }
    }

    id:healthWidget
    titleKey:"Health"

    //record the current slected tab
    property variant currentTab:sleep;

    Rectangle {
        color:"white"
        anchors.horizontalCenter: parent.horizontalCenter
        height:parent.height*0.8
        width:parent.width*0.4

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20

            PXText {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                color: "black"
                textKey: "Magic"
            }
            Image {
                id:device
                property bool deviceSlection: true
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                source:'../../Images/box-checked.png'
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(device.deviceSlection === false){
                            device.deviceSlection = true
                            device.source = '../../Images/box-checked.png'
                            weightInforChart.visible = true
                            sleepInforChart.visible = true
                            nutritionInforTable.visible = true
                        }
                        else{
                            device.deviceSlection = false
                            device.source = '../../Images/box-unchecked.png'
                            weightInforChart.visible = false
                            sleepInforChart.visible = false
                            nutritionInforTable.visible = false
                        }
                    }
                }
            }
        }
    }

    configurationView: Rectangle {
        //anchors.fill: parent
        height: parent.height
        width: parent.width
        color:'black'
    }



    contentView:Rectangle {
        //visible:false
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.fill: parent
        PXTab {
            id:weight
            tabIdentifier: "weight tab"
            anchors.right: sleep.left
            anchors.rightMargin: 60
            textKey:"weight"
            tabDelegate: healthWidget
            state: "DISABLED"
        }
        PXTab {
            id:sleep
            tabIdentifier: "sleep tab"
            anchors.horizontalCenter:parent.horizontalCenter
            textKey:"sleep"
            tabDelegate: healthWidget
            state:"ABLED"
        }
        PXTab {
            id:nutrition
            tabIdentifier: "nutrition tab"
            anchors.left: sleep.right
            anchors.leftMargin: 60
            textKey:"nutrition"
            tabDelegate: healthWidget
            state: "DISABLED"
        }

        Rectangle {
            id: weightInfor
            width:parent.parent.width-20
            anchors.top: sleep.bottom
            height:parent.parent.height-sleep.height-10
            anchors.horizontalCenter: sleep.horizontalCenter
            visible:weight.tabInforVisibility
            property variant currentRadio: monthlyRadioButton
            Image {
                id:weightInforChart
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
            id: sleepInfor
            width: parent.parent.width-20
            anchors.top: sleep.bottom
            height: parent.parent.height-sleep.height-10
            anchors.horizontalCenter: sleep.horizontalCenter
            visible: sleep.tabInforVisibility
            Image{
                id:sleepInforChart
                anchors.left: parent.left
                source: "../../Images/sleep.png"
            }
        }

        Rectangle {
            id:nutritionInfor
            width:parent.parent.width-20
            anchors.top: sleep.bottom
            height:parent.parent.height-sleep.height-10
            anchors.horizontalCenter: sleep.horizontalCenter
            visible:nutrition.tabInforVisibility
            Image {
                id:nutritionInforTable
                anchors.left: parent.left
                source: "../../Images/nutrition.png"
            }
        }
    }
}
