Qt.include("Controllers/PXPaneLanguage.js");

/**
 * @file
 * Provides a set of functions, used to provide translation functionality
 * between different languages.  This replaces the default, QT provided
 * translation libraries, and provides the benefit of allowing realtime /
 * immediate translation.
 */

/**
 * Returns a translation table, used for translating strings between
 * different languages.  This is implemented as a closure, to prevent
 * needing to initialize the large translation table on each call.
 * Instead, the returned funciton has access to one, shared version
 * of the table.
 *
 * @return object
 *   The returned object has keys, describing languages, in their
 *   ISO 639-1 alpha-2 form.  The values are also objects, with the
 *   untranslated verison of each string as a key, and the translated
 *   version as the value.
 */
var translationTable = (function () {

    var table = false;

    return function () {

        if (table === false) {

            table = {
                "zh" : {
                    "Help" : "帮助",
                    "Network Password" : "网络密码",
                    "Security Type" : "安全类型",
                    "Other Network Name" : "其他网络名",
                    "Select Network" : "选择网络",
                    "WiFi" : "WiFi",
                    "Language" : "语言",
                    "Settings" : "设置",
                    "Use Celsius Scale" : "采用摄氏度",
                    "Use Fahrenheit Scale" : "采用华氏度",
                    "Weather" : "天气",
                    "24 Hr Time?" : "24小时制",
                    "Clock" : "时钟",
                    "Video Information Data Source" : "视频信息数据源",
                    "Podcasts" : "播客",
                    "TV Shows" : "电视剧",
                    "Movies" : "电影",
                    "Video" : "视频",
                    "Health Information Data Source" : "健康信息数据源",
                    "weekly" : "按周",
                    "monthly" : "按月",
                    "yearly" : "按年",
                    "Nutrition" : "营养",
                    "Sleep" : "睡觉",
                    "Weight" : "重量",
                    "Health" : "健康",
                    "Add additional stock:" : "加入额外的股票",
                    "Stocks" : "股票",
                    "Follow additional twitterers:" : "关注额外的特维特账户",
                    "Twitter" : "特维特",
                    "Add news topics:" : "加新的话题",
                    "News" : "新闻",
                    "Log Out" : "注销",
                    "Settings" : "设置",
                    "Weather" : "天气",
                    "Clock" : "时钟",
                    "Video" : "视频",
                    "Health" : "健康",
                    "Stocks" : "股票",
                    "Twitter" : "特维特",
                    "News" : "新闻",
                    "Next" : "下一个",
                    "Back" : "回来",
                    "Network Password" : "网络密码",
                    "Security Type" : "安全类型",
                    "Other Network Name" : "其他网络名",
                    "Select Network" : "选择网络",
                    "Fingerprint input:" : "指纹读入",
                    "BeyondMirror" : "超镜",
                    "News" : "新闻",
                    "Twitter" : "特维特",
                    "Stocks" : "股票",
                    "Health" : "健康",
                    "Video" : "视频",
                    "Clock" : "时钟",
                    "Weather" : "天气",
                    "Settings" : "设置",
                    "WEP" : "WEP",
                    "WPA" : "WPA",
                    "WPA2" : "WPA2",
                    "Weak Network" : "信号弱",
                    "Medium Network" : "信号中",
                    "Strong Network" : "信号强",
                    "English" : "英语",
                    "Chinese" : "中文",
                    "Finish" : "芬兰语",
                    "French" : "法语",
                    "German" : "德语",
                    "Hebrew" : "希伯来语",
                    "Spanish": "西班牙语",
                    "Swedish":"瑞士语",
                    "Sunday" : "星期日",
                    "Monday" : "星期一",
                    "Tuesday" : "星期二",
                    "Wednesday" : "星期三",
                    "Thursday" : "星期四",
                    "Friday" : "星期五",
                    "iTunes" : "iTunes",
                    "Friends Season1 02" : "老友记第一季 02",
                    "Friends Season2 04" : "老友记第二季 04",
                    "Friends Season3 07" : "老友记第三季 07",
                    "Friends Season5 05" : "老友记第五季 05",
                    "Friends Season6 06" : "老友记第六季 06",
                    "Magic Device" : "魔法装置",
                    "Fantastic Device":"奇异装置",
                    "@gapersblock" : "@gapersblock",
                    "Local News" : "地方新闻",
                    "WEP" : "WEP",
                    "WPA" : "WPA",
                    "WPA2" : "WPA2",
                    "Italian" : "意大利语",
                    "Polish" : "波兰语",
                    "GOOG" : "谷歌",
                    "APPL" : "苹果",
                    "624.60" :"624.60",
                    "chicago":"芝加哥",
                    "Bottle Rocket":"瓶装火箭",
                    "Rushmore":"青春年少",
                    "The Royal Tenenbaums":"特南鲍姆一家",
                    "Brazil":"巴西",
                    "Titanic":"铁达尼克",
                    "Funny":"有趣",
                    "Excitting":"激动",
                    "Surprised":"惊奇",
                    "Next":"下一个",
                    "Yes":"是的",
                    "Save Account":"保存帐户吗",
                    "Do you wish to save your account for future use?Doing so will allow BeyondMirror to keep your settings and preferences for next time.":
                    "你想要保存你的帐户以便下次登录吗？如果是的话，超镜会保存你的个人设置以及偏好。"
                },
            };
        }

        return table;
    }
}());

/**
 * Translates a term between English and the current, system language
 * setting.  If no translation is available for the given string in the
 * currently selected language, the English version is returned and
 * an error is logged.
 *
 * @param string term
 *   An untranslated, English verison of the desired text
 *
 * @return string
 *   The translated version of the string, if available.  Otherwise,
 *   returns back the provided English version.
 */
var translateTerm = function (term, new_language) {

    var current_language, table;

    current_language = new_language;

    if (current_language === "en") {

        return term;

    } else {

        table = translationTable();

        if (table[current_language] && table[current_language][term]) {

            return table[current_language][term];

        } else {

//            console.log('"' + term + '" : "",');
            return term;
        }
    }
};
