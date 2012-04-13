import "../../JS/PXApp.js" as App
import "../"
import QtQuick 1.1
import QtWebKit 1.0

/**
 * @file
 * This file creates a draggable, placeable window that displays information about
 * a given tweet.  This window is intended to be reused for all tweets (ie clicking
 * on different tweets will cause them each to reuse / obtain this window).
 */

PXWindowDraggable {

    function setParams (params) {

        twitterWindow.titleKey = params.title;
        webView.url = params.url;
    }

    id: twitterWindow
    uniqueIdentifier: "twitter window draggable"

    contentView: Rectangle {
        id: contentView
        color: "black"
        anchors.fill: parent

        WebView {
            id: webView
            anchors.fill: parent
            preferredHeight: twitterWindow.height
            preferredWidth: twitterWindow.width
            url: "qrc:/qtquickplugin/html/welcome.html"
        }
    }
}
