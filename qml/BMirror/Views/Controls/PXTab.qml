import "../"
import QtQuick 1.1

Rectangle {

    // Untranslated text key for the button label
    property string textKey;

    // Unique string identifier for the tab, for use when identifying
    // button presses in the "Tab Delegate Protocol"
    property string tabIdentifier;

    //
    property variant tabDelegate;
    //the information of tab which needs to display
    property bool tabInforVisibility

    id: tabItem
    width: 80
    height: 40
    color: "#000000"
    //radius: 5
    //border.color: "#ffffff"

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {
            if(tabItem.state != "ABLED"){
                tabItem.state ="ABLED"
                if (tabItem.tabDelegate) {
                    //console.log(tabItem.textKey);
                    tabItem.tabDelegate.tabItemClicked(tabItem);
                }
            }
        }
    }

    PXText {
        id: label
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        textKey: tabItem.textKey
    }

    states: [
        State {
            name: "DISABLED"
            PropertyChanges {
                target: tabItem
                color: "#000000"
                tabInforVisibility: false
            }
            PropertyChanges{
                target:label
                color:"#ffffff"
            }
        },

        State {
            name: "ABLED"
            PropertyChanges {
                target:tabItem
                color: "#ffffff"
                tabInforVisibility: true
            }
            PropertyChanges{
                target:label
                color:"#000000"
            }
        }
    ]
}
