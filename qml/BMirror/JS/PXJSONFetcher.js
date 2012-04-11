Qt.include("JSON2.js");

var fetcher = (function () {

    // Have a simple cache to store JSON returned from
    // URLS when we're doing GET calls (since GET calls
    // must be non-mutating)
    var get_cache = {};

    return {
        get: function (url, callback) {

            if (get_cache[url]) {

                callback(get_cache[url], url);

            } else {

                var request = new XMLHttpRequest();

                request.open("GET", url, true);
                request.onreadystatechange = function (event) {

                    var result, i, text;

                    if (request.readyState === 4) {

                        if (request.status === 200) {

                            if (request.responseText.substring(0, 3) == "\n//") {

                                text = request.responseText.substring(3);

                            } else {

                                text = request.responseText;
                            }

                            result = JSON.parse(text);
                            get_cache[url] = result;

                            callback(result, url);
                        }
                    };
                }

                request.send(null);
            }
        }
    }
}());
