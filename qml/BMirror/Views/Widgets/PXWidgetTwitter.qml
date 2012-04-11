import "../"
import QtQuick 1.1

PXWindowWidget {

    id: twitterWidget
    titleKey: "Twitter"

    contentView: PXListModelJSON {
        feedUrl: "http://search.twitter.com/search.json?q=%40twitterapi%20-via"
        modelIdentifier: "Twitter JSON Model"
        jsonResultDelegate: twitterWidget
    }
}
