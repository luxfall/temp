import QtQuick 2.15
import QtQuick.Layouts 2.15

Rectangle {
    id: root

    property string btnText:    "button"
    property var    theme:      null

    signal clicked()

    readonly property string _font:        theme.font
    readonly property int    _fontSize:    theme.textFontSize
    readonly property string _btnBg:       theme.bgColor
    readonly property string _hoverBg:     theme.focusBgColor
    readonly property string _divider:     theme.dividerColor
    readonly property string _color:     theme.textColor
    readonly property string _borderColor: theme.boxBorderColor

    property bool hovered: false

    height: 2 * _fontSize
    width:  height
    color:  hovered ? _hoverBg : "transparent"
    radius: height / 2
    border.width: 1
    border.color: _borderColor

    Text {
        anchors.centerIn: parent
        text:  root.btnText
        color: root._color
        font.family:    root._font
        font.pixelSize: root._fontSize
        font.letterSpacing: 1
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered:  root.hovered = true
        onExited:   root.hovered = false
        onClicked:  root.clicked()
    }
}
