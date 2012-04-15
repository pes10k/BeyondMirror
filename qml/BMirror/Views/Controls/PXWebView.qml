import QtQuick 1.1
import QtWebKit 1.0

Rectangle {

    // The URL that this webview should display.  This is passed directly
    // to the contained webview element
    property string url;

    id: webViewContainer
    anchors.fill: parent
    color: "red"

    Rectangle {

        id: progressBarContainer
        height: webView.progress < 1 ? 25 : 0
        visible: webView.progress < 1
        color: "#000000"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Rectangle {
            id: progressBarEmpty
            color: "#696969"
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 0
            anchors.fill: parent

            Rectangle {
                id: progressBarComplete
                color: "red"
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                anchors.rightMargin: parent.width
            }
        }

    }

    WebView {
        id: webView
        anchors.top: progressBarContainer.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0
        url: webViewContainer.url

        onProgressChanged: {
            progressBarComplete.anchors.rightMargin = parent.width - (parent.width * webView.progress);
        }
    }
}
