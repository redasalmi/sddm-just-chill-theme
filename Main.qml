import QtGraphicalEffects 1.12
import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: container

    property int sessionIndex: session.index

    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    TextConstants {
        id: textConstants
    }

    Connections {
        function onLoginSucceeded() {
            errorMessage.color = "steelblue";
            errorMessage.text = textConstants.loginSucceeded;
        }

        function onLoginFailed() {
            errorMessage.color = "red";
            errorMessage.text = textConstants.loginFailed;
        }

        function onInformationMessage(message) {
            errorMessage.color = "red";
            errorMessage.text = message;
        }

        target: sddm
    }

    Image {
        id: background

        anchors.fill: parent
        source: config.background
    }

    Column {
        id: clipRect

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: 500
        height: parent.height
        clip: true

        Rectangle {
            color: "black"
            anchors.fill: parent

            Clock {
                id: clock

                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Column {
                id: mainColumn

                anchors.centerIn: parent
                spacing: 12

                Column {
                    width: parent.width
                    spacing: 4

                    Text {
                        id: lblName

                        color: "white"
                        width: parent.width
                        text: textConstants.userName
                        font.bold: true
                        font.pixelSize: 12
                    }

                    TextBox {
                        id: name

                        width: parent.width
                        height: 30
                        text: userModel.lastUser
                        font.pixelSize: 14
                        KeyNavigation.backtab: rebootButton
                        KeyNavigation.tab: password
                        Keys.onPressed: function(event) {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, sessionIndex);
                                event.accepted = true;
                            }
                        }
                    }

                }

                Column {
                    width: parent.width
                    spacing: 4

                    Text {
                        id: lblPassword

                        color: "white"
                        width: parent.width
                        text: textConstants.password
                        font.bold: true
                        font.pixelSize: 12
                    }

                    PasswordBox {
                        id: password

                        width: parent.width
                        height: 30
                        font.pixelSize: 14
                        KeyNavigation.backtab: name
                        KeyNavigation.tab: session
                        Keys.onPressed: function(event) {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, sessionIndex);
                                event.accepted = true;
                            }
                        }
                    }

                }

                Row {
                    spacing: 4
                    width: parent.width / 2
                    z: 100

                    Column {
                        z: 100
                        width: parent.width * 1.3
                        spacing: 4
                        anchors.bottom: parent.bottom

                        Text {
                            id: lblSession

                            width: parent.width
                            text: textConstants.session
                            wrapMode: TextEdit.WordWrap
                            font.bold: true
                            font.pixelSize: 12
                        }

                        ComboBox {
                            id: session

                            width: parent.width
                            height: 30
                            font.pixelSize: 14
                            arrowIcon: Qt.resolvedUrl("angle-down.png")
                            model: sessionModel
                            index: sessionModel.lastIndex
                            KeyNavigation.backtab: password
                            KeyNavigation.tab: layoutBox
                        }

                    }

                    Column {
                        z: 101
                        width: parent.width * 0.7
                        spacing: 4
                        anchors.bottom: parent.bottom
                        visible: keyboard.enabled && keyboard.layouts.length > 0

                        Text {
                            id: lblLayout

                            width: parent.width
                            text: textConstants.layout
                            wrapMode: TextEdit.WordWrap
                            font.bold: true
                            font.pixelSize: 12
                        }

                        LayoutBox {
                            // arrowIcon: Qt.resolvedUrl("angle-down.png")

                            id: layoutBox

                            width: parent.width
                            height: 30
                            font.pixelSize: 14
                            KeyNavigation.backtab: session
                            KeyNavigation.tab: loginButton
                        }

                    }

                }

                Column {
                    width: parent.width

                    Text {
                        id: errorMessage

                        anchors.horizontalCenter: parent.horizontalCenter
                        text: textConstants.prompt
                        font.pixelSize: 10
                    }

                }

                Row {
                    property int btnWidth: Math.max(loginButton.implicitWidth, shutdownButton.implicitWidth, rebootButton.implicitWidth, 80) + 8

                    spacing: 4
                    anchors.horizontalCenter: parent.horizontalCenter

                    Button {
                        id: loginButton

                        text: textConstants.login
                        width: parent.btnWidth
                        onClicked: sddm.login(name.text, password.text, sessionIndex)
                        KeyNavigation.backtab: layoutBox
                        KeyNavigation.tab: shutdownButton
                    }

                    Button {
                        id: shutdownButton

                        text: textConstants.shutdown
                        width: parent.btnWidth
                        onClicked: sddm.powerOff()
                        KeyNavigation.backtab: loginButton
                        KeyNavigation.tab: rebootButton
                    }

                    Button {
                        id: rebootButton

                        text: textConstants.reboot
                        width: parent.btnWidth
                        onClicked: sddm.reboot()
                        KeyNavigation.backtab: shutdownButton
                        KeyNavigation.tab: name
                    }

                }

            }

        }

    }

}
