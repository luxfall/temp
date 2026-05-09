import QtQuick 2.15

FocusScope {
    id: root

    property string displayText: ""
    property string   caption:    ""
    property bool   isActive:    false
    property var    theme:       null
    property Component child: Component {
        id: defaultTextElement
        Text {
            text:  root.displayText
            color: root._textColor
            font.family:   root._font
            font.pixelSize: root._fontSize
        }
    }
    readonly property string text: loader.item.text

    readonly property string _font:     theme.font
    readonly property int    _fontSize: theme.textFontSize
    readonly property string _textColor:theme.textColor
    readonly property string _focusBg:  theme.focusBgColor

    function reset() {
        if (loader.item) {
            loader.item.text = ""
            loader.item.forceActiveFocus()
        }
    }

    width:  0
    height: _fontSize

    Rectangle {
        anchors.fill: parent
        color:  "transparent"

        Row {
            anchors.centerIn: parent
            spacing: 6

            Text {
                id: captionText
                width: root.width / 4
                text: root.caption
                color: cfg.textColor
                font.family: cfg.font
                font.pixelSize: cfg.textFontSize
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: arrowLeft
                text: ""
                color:  root.isActive ? root._textColor : "transparent"
                font.family: root._font
                font.pixelSize: root._fontSize
            }

            Loader {
                anchors.verticalCenter: parent.verticalCenter
                id: loader
                width: root.width - captionText.width - arrowRight.width - arrowLeft.width - 3 * parent.spacing
                sourceComponent: child
            }

            Text {
                id: arrowRight
                text: ""
                color:  root.isActive ? root._textColor : "transparent"
                font.family: root._font
                font.pixelSize: root._fontSize
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    activeFocusOnTab: true
}
