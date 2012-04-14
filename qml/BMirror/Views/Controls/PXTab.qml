import "../"
import QtQuick 1.1

/**
 * "Tab Delegate Protocol"
 *
 * - tabItemClicked (tabElement)
 *   Will be called on the tab delegate whenever
 *   the given tab is clicked.
 */
Rectangle {

    function isActive () {
        console.log(tabItem.state)
        return tabItem.state == "ABLED";
    }

    function setActiveState (isActive) {
        tabItem.state = isActive === true ? "ABLED" : "DISABLED";
    }

    // Untranslated text key for the button label
    property string textKey;

    // Unique string identifier for the tab, for use when identifying
    // button presses in the "Tab Delegate Protocol"
    property string tabIdentifier;

    // Refernece to an object that should implement the "Tab Delegate Protocol",
    // defined above.
    property variant tabDelegate;

    //the information of tab which needs to display
    property bool tabInforVisibility

    color: "transparent"
    id: tabItem
    width: 100
    height: 40
    state: "ABLED"

    Rectangle {

        id: tabItemContainer
        color: "#000000"
        height: parent.height
        width: parent.width
        radius: 5
        y: 5
        border.color: "#000000"

        MouseArea {
            id: mouseArea
            anchors.fill: parent

            onClicked: {
                if (tabItem.state != "ABLED") {
                    tabItem.state = "ABLED"
                }

                if (tabItem.tabDelegate) {
                    tabItem.tabDelegate.tabItemClicked(tabItem);
                }
            }
        }

        PXText {
            id: label
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            textKey: tabItem.textKey
        }
    }

    states: [
        State {
            name: "DISABLED"
            PropertyChanges {
                target: tabItemContainer
                color: "#000000"
                border.color: "#ffffff"
            }
            PropertyChanges {
                target: tabItem
                tabInforVisibility: false
            }
            PropertyChanges{
                target: label
                color: "#ffffff"
            }
        },
        State {
            name: "ABLED"
            PropertyChanges {
                target: tabItemContainer
                color: "#ffffff"
            }
            PropertyChanges {
                target: tabItem
                tabInforVisibility: true
            }
            PropertyChanges{
                target: label
                color: "#000000"
            }
        }
    ]
}
