/**
 * @file
 * This QML a reusable interface button, used for launching
 * applications from the bottom, launching toolbar.
 *
 * Launcher Delegate Protocol
 * ===
 *
 * Required
 * ---
 *
 *  This method will be called on the delegate whenever this launcher item
 *  is clicked.  The delegate can then use the provided launcherItem's
 *  identifier to decide how to respond.
 *  - launcherItemClicked (launcherItem)
 */
import "../"
import QtQuick 1.1

Rectangle {

    // Including elements should set this property to be the path to
    // the image to use for this launcher item.
    property string launcherImage;

    // Including elements should set this string to be a unique identifier
    // for the item, so that the element implementing the "Launcher Delegate
    // Protocol" can identify which button was pressed.
    property string launcherIdentifier;

    // Including elements should set this property to be a reference to an
    // object that implements the "Launcher Delegate Protocol", which receives
    // notifications of when this launcher was clicked on
    property variant launcherDelegate;

    // Including objects should define this string to be the untranslated text
    // that shoudl appear below the launcher item (ex "News", "Settings" etc.)
    property string textKey;

    id: launcherItem
    width: 64
    height: 94
    color: "transparent"

    Component.onCompleted: {
        if (launcherItem.launcherDelegate) {
            launcherItem.launcherDelegate.launcherInitilized(launcherItem);
        }
    }

    Rectangle {

        id: launcherItemButton
        width: parent.width
        height: 64
        border.width: 1
        border.color: "#000000"
        radius: 10

        Image {
            id: image
            width: 64
            height: 64
            sourceSize.height: 64
            sourceSize.width: 64
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: launcherItem.launcherImage
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent

            onClicked: {
                if (launcherItem.launcherDelegate) {
                    launcherItem.launcherDelegate.launcherItemClicked(launcherItem);
                }

                launcherItem.state = "PRESSED"
            }
        }
    }

    PXText {
        id: textLabel
        textKey: launcherItem.textKey
        width: parent.width
        height: 20
        anchors.bottom: parent.bottom
        color: "white"
        font.pointSize: 16
        horizontalAlignment: Text.AlignHCenter
    }

    states: [
        State {
            name: "PRESSED"

            PropertyChanges {
                target: launcherItemButton
                color: "#999999"
                opacity: .8
            }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation {
                properties: "opacity";
                easing.type: Easing.InOutQuad
            }
            PropertyAnimation {
                target: launcherItemButton
                properties: "color"
                duration: 100
            }
        }
    ]
}
