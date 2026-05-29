import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height
    color: "#000208"

    TextConstants { id: textConstants }

    // ── Background ────────────────────────────────────────────────────────
    Image {
        id: bg
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        smooth: true
        opacity: 1.0
        onStatusChanged: {
            if (status === Image.Error)
                source = Qt.resolvedUrl("background.png")
        }
    }

    // ── Right-side dark overlay ───────────────────────────────────────────
    Rectangle {
        anchors.fill: parent
        rotation: -90
        transformOrigin: Item.Center
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#00000208" }
            GradientStop { position: 0.5; color: "#88000208" }
            GradientStop { position: 1.0; color: "#ee000208" }
        }
    }

    // ── Bottom fade ───────────────────────────────────────────────────────
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.18
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#00000208" }
            GradientStop { position: 1.0; color: "#cc000208" }
        }
    }

    // ── Top fade ──────────────────────────────────────────────────────────
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.12
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#88000208" }
            GradientStop { position: 1.0; color: "#00000208" }
        }
    }

    // ── Scanlines ─────────────────────────────────────────────────────────
    Canvas {
        anchors.fill: parent
        opacity: 0.045
        onPaint: {
            var ctx = getContext("2d")
            ctx.strokeStyle = "#4da6ff"
            ctx.lineWidth = 1
            for (var y = 0; y < height; y += 3) {
                ctx.beginPath()
                ctx.moveTo(0, y)
                ctx.lineTo(width, y)
                ctx.stroke()
            }
        }
    }

    // ── Floating code particles ───────────────────────────────────────────
    Repeater {
        model: 28
        delegate: Text {
            property real _dur:   10000 + Math.random() * 14000
            property real _delay: Math.random() * 14000
            x: Math.random() * root.width
            y: root.height + 10
            text: ["0","1","lain","wired","layer","kernel","root","node","0","1","NULL","echo","0","1","0x00"][Math.floor(Math.random()*15)]
            color: "#1a6eb5"
            opacity: 0.12 + Math.random() * 0.22
            font.family: "Monospace"
            font.pixelSize: 9 + Math.floor(Math.random() * 9)

            SequentialAnimation on y {
                loops: Animation.Infinite
                PauseAnimation  { duration: _delay }
                NumberAnimation { from: -30; to: root.height + 30; duration: _dur; easing.type: Easing.Linear }
            }
        }
    }

    // ── Tagline flicker ───────────────────────────────────────────────────
    Text {
        id: tagline
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 28
        anchors.rightMargin: 36
        text: "present day  -  present time"
        color: "#2a6fa8"
        font.family: "Monospace"
        font.pixelSize: 10
        font.letterSpacing: 4
        opacity: 0

        SequentialAnimation on opacity {
            loops: Animation.Infinite
            PauseAnimation  { duration: 4000 }
            NumberAnimation { to: 0.7;  duration: 150 }
            PauseAnimation  { duration: 60 }
            NumberAnimation { to: 0.15; duration: 80 }
            PauseAnimation  { duration: 30 }
            NumberAnimation { to: 0.7;  duration: 100 }
            PauseAnimation  { duration: 5000 }
            NumberAnimation { to: 0;    duration: 400 }
        }
    }

    // ── Clock ─────────────────────────────────────────────────────────────
    Column {
        anchors.right: loginPanel.right
        anchors.bottom: loginPanel.top
        anchors.bottomMargin: 28
        spacing: 6

        Text {
            id: clockText
            anchors.right: parent.right
            text: Qt.formatTime(new Date(), "HH:mm:ss")
            color: "#3a8fd4"
            font.family: "Monospace"
            font.pixelSize: 48
            font.weight: Font.Thin
            font.letterSpacing: 6

            Timer {
                interval: 1000; running: true; repeat: true
                onTriggered: clockText.text = Qt.formatTime(new Date(), "HH:mm:ss")
            }
        }

        Text {
            anchors.right: parent.right
            text: Qt.formatDate(new Date(), "dddd  -  dd MMMM yyyy")
            color: "#1a5a99"
            font.family: "Monospace"
            font.pixelSize: 12
            font.letterSpacing: 2
        }
    }

    // ────────────────────────────────────────────────────────────────────
    // LOGIN PANEL
    // ────────────────────────────────────────────────────────────────────
    Rectangle {
        id: loginPanel
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: parent.width * 0.025
        width: 310
        height: sessionLabel.y + sessionLabel.height + sessionBox.height + 36
        color: "#04070f"
        border.color: "#112244"
        border.width: 1
        radius: 2
        opacity: 0.96
        z: 10

        // Corners and Glows
        Rectangle { width:22; height:2; anchors.top:parent.top; anchors.left:parent.left; color:"#3a8fd4" }
        Rectangle { width:2; height:22; anchors.top:parent.top; anchors.left:parent.left; color:"#3a8fd4" }
        Rectangle { width:22; height:2; anchors.bottom:parent.bottom; anchors.right:parent.right; color:"#0d3a6e" }
        Rectangle { width:2; height:22; anchors.bottom:parent.bottom; anchors.right:parent.right; color:"#0d3a6e" }
        Rectangle { anchors.top:parent.top; anchors.left:parent.left; anchors.right:parent.right; height:1; color:"#1e5fa0"; opacity:0.7 }

        // ── Title ─────────────────────────────────────────────────────
        Text {
            id: titleText
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 28
            text: "// lain //"
            color: "#3a8fd4"
            font.family: "Monospace"
            font.pixelSize: 13
            font.letterSpacing: 9
        }

        Text {
            id: subtitleText
            anchors.top: titleText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 4
            text: "[ enter the wired ]"
            color: "#0d3a6e"
            font.family: "Monospace"
            font.pixelSize: 9
            font.letterSpacing: 3
        }

        Rectangle {
            id: sep
            anchors.top: subtitleText.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 26
            anchors.topMargin: 12
            height: 1
            color: "#0d2a50"
        }

        // ── User label + combo ────────────────────────────────────────
        Text {
            id: userLabel
            anchors.top: sep.bottom
            anchors.left: parent.left
            anchors.leftMargin: 26
            anchors.topMargin: 14
            text: "USER"
            color: "#0d4a80"
            font.family: "Monospace"
            font.pixelSize: 8
            font.letterSpacing: 4
        }

        ComboBox {
            id: userBox
            anchors.top: userLabel.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 26
            anchors.topMargin: 6
            height: 34
            z: 20
            color: "#020b18"
            borderColor: "#1a5a99"
            focusColor: "#4aa7ff"
            hoverColor: "#2a6fa8"
            menuColor: "#020b18"
            textColor: "#8fcaff"
            model: userModel
            index: userModel.lastIndex >= 0 ? userModel.lastIndex : 0
            property string selectedUserName: userModel.lastUser
            rowDelegate: Component {
                Text {
                    anchors.fill: parent
                    anchors.margins: 4
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    color: userBox.textColor
                    font: userBox.font

                    property string userName: parent.modelItem && parent.modelItem.name ? parent.modelItem.name : ""
                    property string displayName: parent.modelItem && parent.modelItem.realName ? parent.modelItem.realName : userName

                    text: displayName

                    onUserNameChanged: updateSelectedUserName()
                    Component.onCompleted: updateSelectedUserName()

                    function updateSelectedUserName() {
                        if (parent && parent.parent === userBox && userName !== "")
                            userBox.selectedUserName = userName
                    }
                }
            }
            font.family: "Monospace"
            font.pixelSize: 13
        }

        // ── Password label + field ────────────────────────────────────
        Text {
            id: passLabel
            anchors.top: userBox.bottom
            anchors.left: parent.left
            anchors.leftMargin: 26
            anchors.topMargin: 14
            text: "PASSWORD"
            color: "#0d4a80"
            font.family: "Monospace"
            font.pixelSize: 8
            font.letterSpacing: 4
        }

        TextBox {
            id: pwBox
            anchors.top: passLabel.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 26
            anchors.topMargin: 6
            height: 34
            z: 5
            echoMode: TextInput.Password
            color: "#020b18"
            borderColor: "#1a5a99"
            focusColor: "#4aa7ff"
            hoverColor: "#2a6fa8"
            textColor: "#8fcaff"
            radius: 1
            font.family: "Monospace"
            font.pixelSize: 14

            Keys.onReturnPressed: doLogin()
            Keys.onEnterPressed:  doLogin()
        }

        // ── Error message ─────────────────────────────────────────────
        Text {
            id: errorMsg
            anchors.top: pwBox.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 26
            anchors.topMargin: 6
            visible: text !== ""
            wrapMode: Text.WordWrap
            color: "#aa2222"
            font.family: "Monospace"
            font.pixelSize: 9
            horizontalAlignment: Text.AlignHCenter
        }

        // ── Login button ──────────────────────────────────────────────
        Rectangle {
            id: loginBtn
            anchors.top: errorMsg.visible ? errorMsg.bottom : pwBox.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 26
            anchors.topMargin: 12
            height: 34
            z: 5
            color: "#030610"
            border.color: "#1a5a99"
            border.width: 1
            radius: 1

            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: 2
                color: "#3a8fd4"
                opacity: loginMouseArea.containsMouse ? 1.0 : 0.3
                Behavior on opacity { NumberAnimation { duration: 150 } }
            }

            Text {
                id: loginBtnText
                anchors.centerIn: parent
                text: "CONNECT TO THE WIRED"
                color: "#2a7fcf"
                font.family: "Monospace"
                font.pixelSize: 9
                font.letterSpacing: 3
            }

            Rectangle {
                id: btnCursor
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width: 5; height: 14
                color: "#3a8fd4"
                visible: loginMouseArea.containsMouse
                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    running: btnCursor.visible
                    NumberAnimation { to: 0; duration: 350 }
                    NumberAnimation { to: 1; duration: 350 }
                }
            }

            MouseArea {
                id: loginMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    loginBtn.color = "#06112a"
                    loginBtn.border.color = "#3a8fd4"
                    loginBtnText.color = "#6bb8ff"
                }
                onExited: {
                    loginBtn.color = "#030610"
                    loginBtn.border.color = "#1a5a99"
                    loginBtnText.color = "#2a7fcf"
                }
                onClicked: doLogin()
            }
        }

        // ── Session label + combo ─────────────────────────────────────
        Text {
            id: sessionLabel
            anchors.top: loginBtn.bottom
            anchors.left: parent.left
            anchors.leftMargin: 26
            anchors.topMargin: 14
            text: "SESSION"
            color: "#0d4a80"
            font.family: "Monospace"
            font.pixelSize: 8
            font.letterSpacing: 4
        }

        ComboBox {
            id: sessionBox
            anchors.top: sessionLabel.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 26
            anchors.topMargin: 6
            height: 34
            z: 20
            color: "#020b18"
            borderColor: "#1a5a99"
            focusColor: "#4aa7ff"
            hoverColor: "#2a6fa8"
            menuColor: "#020b18"
            textColor: "#8fcaff"
            model: sessionModel
            index: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0
            font.family: "Monospace"
            font.pixelSize: 12
        }
    }

    // ── Power buttons ─────────────────────────────────────────────────────
    Row {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 28
        spacing: 24

        Text {
            id: rebootBtn
            text: "REBOOT"
            color: "#0d2a50"
            font.family: "Monospace"; font.pixelSize: 9; font.letterSpacing: 2
            MouseArea {
                anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                onEntered: rebootBtn.color = "#3a8fd4"
                onExited:  rebootBtn.color = "#0d2a50"
                onClicked: sddm.reboot()
            }
        }

        Text {
            id: shutdownBtn
            text: "SHUTDOWN"
            color: "#0d2a50"
            font.family: "Monospace"; font.pixelSize: 9; font.letterSpacing: 2
            MouseArea {
                anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                onEntered: shutdownBtn.color = "#3a8fd4"
                onExited:  shutdownBtn.color = "#0d2a50"
                onClicked: sddm.powerOff()
            }
        }
    }

    // ── Bottom-left hostname ──────────────────────────────────────────────
    Column {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 28
        spacing: 3

        Text {
            text: sddm.hostName
            color: "#0d2040"; font.family: "Monospace"; font.pixelSize: 10; font.letterSpacing: 2
        }
        Text {
            text: "layer:01 // the wired"
            color: "#071428"; font.family: "Monospace"; font.pixelSize: 9; font.letterSpacing: 3
        }
    }

    // ── SDDM signals ──────────────────────────────────────────────────────
    Connections {
        target: sddm
        onLoginFailed: {
            errorMsg.text = "// authentication failed //"
            pwBox.text = ""
            pwBox.forceActiveFocus()
        }
    }

    function doLogin() {
        errorMsg.text = ""
        if (pwBox.text === "") {
            errorMsg.text = "// no signal detected //"
            return
        }
        var username = userBox.selectedUserName || userModel.lastUser
        if (username === "") {
            errorMsg.text = "// no user selected //"
            return
        }

        sddm.login(username, pwBox.text, sessionBox.index)
    }

    Component.onCompleted: pwBox.forceActiveFocus()
}