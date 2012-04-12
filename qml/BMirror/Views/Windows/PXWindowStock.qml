import "../../JS/PXApp.js" as App
import "../"
import QtQuick 1.1

/**
 * @file
 * This file creates a draggable, placeable window that displays information about
 * a given stock.  This window is intended to be reused for all stocks.
 */

PXWindowDraggable {

    function setParams (params) {

        stockChart.source = "http://chart.finance.yahoo.com/t?s=" + params.call_letters + "&amp;lang=en-US&amp;region=US&amp;width=300&amp;height=180";
        stockWindow.titleKey = params.call_letters;
        stockTitle.textKey = params.name || params.call_letters;
    }

    id: stockWindow
    uniqueIdentifier: "stock window draggable"

    contentView: Rectangle {

        color: "black"
        anchors.fill: parent

        Image {
            id: stockChart
            width: 300
            height: 180
            anchors.top: stockTitle.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            source: ""
        }

        PXText {
            id: stockTitle
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 20
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
