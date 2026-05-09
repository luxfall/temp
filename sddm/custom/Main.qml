import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Effects
import SddmComponents 2.0

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height
    color: cfg.bgColor

    property int currentUserIndex: userModel.lastIndex > 0 ? userModel.lastIndex : 0
    property int currentSessionIndex: sessionModel.lastIndex > 0 ? sessionModel.lastIndex : 0

    function cycleUserForward() {
        var count = userModel.rowCount()
        if (count === 0) return
        root.currentUserIndex = (root.currentUserIndex + 1) % count
    }

    function cycleUserBackward() {
        var count = userModel.rowCount()
        if (count === 0) return
        root.currentUserIndex = (root.currentUserIndex - 1 + count) % count
    }

    QtObject {
        id: cfg

        readonly property string background:      config.background       || ""
        readonly property int    blurRadius:      parseInt(config.blur_radius)      || 64
        readonly property string font:            config.font             || "monospace"
        readonly property string bgColor:         config.bg_color         || "#0000"
        readonly property int    timeFontSize:    parseInt(config.time_font_size)   || 64
        readonly property int    dateFontSize:    parseInt(config.date_font_size)   || 16
        readonly property string timeColor:       config.time_color       || "#ffffff"
        readonly property string dateColor:       config.date_color       || "#aaaaaa"
        readonly property int    boxWidth:        parseInt(config.box_width)        || 340
        readonly property string boxColor:        config.box_bg_color        || "#555555"
        readonly property string boxBorderColor:  config.box_border_color || "#ffffff"
        readonly property int    boxBorderRadius: parseInt(config.box_border_radius) || 4
        readonly property string textColor:      config.text_color      || "#ffffff"
        readonly property int    textFontSize:   parseInt(config.text_font_size)  || 13
        readonly property string dividerColor:    config.divider_color    || "#aaaaaa"
        readonly property string focusBgColor:    config.focus_bg_color   || "#777777"
        readonly property string errorColor:      config.error_color      || "#ff0000"
        readonly property int    errorFontSize:   parseInt(config.error_font_size)  || 13
    }

    Image {
        id: wallpaper
        anchors.fill: parent
        source: cfg.background
        fillMode: Image.PreserveAspectCrop
        visible: false
        asynchronous: true
    }

    MultiEffect {
        anchors.fill: parent
        source: wallpaper
        visible: cfg.background !== ""
        blurEnabled: true
        blur: 0.5
        blurMax: cfg.blurRadius
        blurMultiplier: 1.0
    }

    Rectangle {
        id: centerBox
        anchors.centerIn: parent
        width: cfg.boxWidth
        height: boxColumn.implicitHeight + 48
        color: cfg.boxColor
        border.color: cfg.boxBorderColor
        border.width: 1
        radius: cfg.boxBorderRadius

        Column {
            id: boxColumn
            spacing: 10

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: 24
                leftMargin: 24
                rightMargin: 24
                bottomMargin: 24
            }

            Column {
                id: clockBlock
                width: parent.width

                Text {
                    id: timeLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: cfg.font
                    font.pixelSize: cfg.timeFontSize
                    font.weight: Font.Light
                    color: cfg.timeColor
                    text: Qt.formatTime(new Date(), "HH:mm")
                }

                Text {
                    id: dateLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: cfg.font
                    font.pixelSize: cfg.dateFontSize
                    color: cfg.dateColor
                    text: Qt.formatDate(new Date(), "ddd, MMMM d")
                }

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: {
                        var now = new Date()
                        timeLabel.text = Qt.formatTime(now, "HH:mm")
                        dateLabel.text = Qt.formatDate(now, "ddd, MMMM d")
                    }
                }
            }

            Item {
                width: parent.width
                height: cfg.textFontSize
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width
                    height: 1
                    color: cfg.dividerColor
                }
            }

            Carousel {
                id: sessionField
                width: cfg.boxWidth - 50
                height: cfg.textFontSize
                displayText: getSessionName(root.currentSessionIndex)
                caption: "session"
                isActive: activeFocus
                theme: cfg
                KeyNavigation.down: userField
                KeyNavigation.up: passwordField
                Keys.onTabPressed:   root.cycleSessionForward()
                Keys.onLeftPressed:  root.cycleSessionBackward()
                Keys.onRightPressed: root.cycleSessionForward()
            }

            Carousel {
                id: userField
                width: cfg.boxWidth - 50
                height: cfg.textFontSize
                displayText: getUserName(root.currentUserIndex)
                caption: "login"
                isActive: activeFocus
                theme: cfg
                KeyNavigation.down: passwordField
                KeyNavigation.up: sessionField
                Keys.onTabPressed:   root.cycleUserForward()
                Keys.onLeftPressed:  root.cycleUserBackward()
                Keys.onRightPressed: root.cycleUserForward()
            }

            Carousel {
                id: passwordField
                width: cfg.boxWidth - 50
                height: cfg.textFontSize
                displayText: getUserName(root.currentUserIndex)
                caption: "password"
                isActive: activeFocus
                theme: cfg
                Keys.onReturnPressed: root.doLogin()
                Keys.onEnterPressed:  root.doLogin()
                Keys.onTabPressed:   passwordField
                KeyNavigation.up: userField
                KeyNavigation.down: sessionField

                child: Component {
                    TextInput {
                        id: password
                        echoMode: TextInput.Password
                        passwordCharacter: "•"
                        color: cfg.textColor
                        font.family: cfg.font
                        font.pixelSize: cfg.textFontSize
                        clip: true
                        cursorDelegate: Rectangle {
                            width: 2
                            height: cfg.textFontSize
                            color: cfg.textColor
                            onHeightChanged: height = cfg.textFontSize
                            visible: password.activeFocus
                            anchors.verticalCenter: parent.verticalCenter
                            SequentialAnimation on opacity {
                                loops: Animation.Infinite
                                NumberAnimation { to: 0; duration: 500 }
                                NumberAnimation { to: 1; duration: 500 }
                            }
                        }
                        Component.onCompleted: { password.forceActiveFocus() }
                    }
                }
            }

            Text {
                id: errorMsg
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                color: cfg.errorColor
                font.family: cfg.font
                font.pixelSize: cfg.textFontSize
                text: " "
            }

            RowLayout {
                width: parent.width
                spacing: 10

                Item { Layout.fillWidth: true }

                ActionButton {
                    btnText: "󰍂"
                    onClicked: root.doLogin()
                    theme: cfg
                }
                ActionButton {
                    btnText: ""
                    onClicked: sddm.powerOff()
                    theme: cfg
                }
                ActionButton {
                    btnText: ""
                    onClicked: sddm.reboot()
                    theme: cfg
                }

                Item { Layout.fillWidth: true }
            }
        }
    }

    function getUserName(index) {
        return userModel.data(userModel.index(index, 0), 257)
    }

    function getSessionName(index) {
        return sessionModel.data(sessionModel.index(index, 0), 260)
    }

    function cycleSessionForward() {
        var count = sessionModel.rowCount()
        if (count === 0) return
        root.currentSessionIndex = (root.currentSessionIndex + 1) % count
    }

    function cycleSessionBackward() {
        var count = sessionModel.rowCount()
        if (count === 0) return
        root.currentSessionIndex = (root.currentSessionIndex - 1 + count) % count
    }

    function doLogin() {
        sddm.login(getUserName(root.currentUserIndex), passwordField.text, root.currentSessionIndex)
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            errorMsg.text = "authentication failed"
            passwordField.reset()
            clearErrorTimer.restart()
        }
    }

    Timer {
        id: clearErrorTimer
        interval: 3000
        onTriggered: errorMsg.text = " "
    }
}
