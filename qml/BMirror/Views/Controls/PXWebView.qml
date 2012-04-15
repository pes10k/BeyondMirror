import QtQuick 1.1
import QtWebKit 1.0

Rectangle {

    // The URL that this webview should display.  This is passed directly
    // to the contained webview element
    property string url;

    id: webView

    WebView {
        anchors.fill: parent
        url: webView.url
    }
}
