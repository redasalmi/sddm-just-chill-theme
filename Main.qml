import "./components"
import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: container

    property int sessionIndex: session.index
    property color black: "#000000"
    property color white: "#ffffff"
    property color red: "#ff0000"
    property color steelblue: "#4682b4"

    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true
    Component.onCompleted: {
        if (name.text == "")
            name.focus = true;
        else
            password.focus = true;
    }
    width: 1600
    height: 900

    Connections {
        function onLoginSucceeded() {
            errorMessage.color = steelblue;
            errorMessage.text = textConstants.loginSucceeded;
        }

        function onLoginFailed() {
            errorMessage.color = red;
            errorMessage.text = textConstants.loginFailed;
        }

        function onInformationMessage(message) {
            errorMessage.color = red;
            errorMessage.text = message;
        }

        target: sddm
    }

    TextConstants {
        id: textConstants
    }

    Background {
        id: background_image

        anchors.fill: parent
        source: Qt.resolvedUrl(config.background)
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        color: black
        width: 500
        height: parent.height
        anchors.right: parent.right
    }

    Column {
        spacing: 5
        width: 500
        height: parent.height
        anchors.right: parent.right

        Rectangle {
            color: black
            width: parent.width
            height: parent.height * 0.25

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                SpClock {
                    width: parent.width
                    height: parent.height
                }

            }

        }

        Rectangle {
            color: black
            width: parent.width
            height: parent.height * 0.5

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5

                Rectangle {
                    width: 300
                    height: 60
                    color: black

                    Text {
                        id: lblName

                        color: white
                        width: parent.width
                        text: textConstants.userName
                        font.bold: true
                        font.pixelSize: 12
                    }

                    TextBox {
                        id: name

                        radius: 4
                        width: parent.width
                        height: 40
                        anchors.bottom: parent.bottom
                        text: userModel.lastUser
                        font.pixelSize: 18
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

                Rectangle {
                    width: 300
                    height: 60
                    color: black

                    Text {
                        id: lblPassword

                        color: white
                        width: parent.width
                        text: textConstants.password
                        font.bold: true
                        font.pixelSize: 12
                    }

                    PasswordBox {
                        id: password

                        radius: 4
                        width: parent.width
                        height: 40
                        anchors.bottom: parent.bottom
                        font.pixelSize: 18
                        KeyNavigation.backtab: name
                        KeyNavigation.tab: login
                        Keys.onPressed: function(event) {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, sessionIndex);
                                event.accepted = true;
                            }
                        }
                    }

                }

                Rectangle {
                    width: 300
                    height: 60
                    color: black

                    Button {
                        id: login

                        radius: 4
                        width: parent.width
                        height: 40
                        anchors.bottom: parent.bottom
                        text: textConstants.login
                        color: white
                        textColor: black
                        borderColor: white
                        pressedColor: white
                        activeColor: white
                        KeyNavigation.backtab: password
                        KeyNavigation.tab: suspend
                        onClicked: sddm.login(name.text, password.text, sessionIndex)
                    }

                }

            }

        }

        Rectangle {
            color: black
            width: parent.width
            height: parent.height * 0.25

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5

                SpButton {
                    id: suspend_btn

                    width: 100
                    height: 100
                    label: textConstants.suspend
                    icon: Qt.resolvedUrl("assets/suspend.svg")
                    KeyNavigation.tab: reboot_btn
                    KeyNavigation.backtab: login
                    onClicked: sddm.suspend()
                }

                SpButton {
                    id: reboot_btn

                    width: 100
                    height: 100
                    label: textConstants.reboot
                    icon: Qt.resolvedUrl("assets/reboot.svg")
                    KeyNavigation.tab: shutdown_btn
                    KeyNavigation.backtab: suspend_btn
                    onClicked: sddm.reboot()
                }

                SpButton {
                    id: shutdown_btn

                    width: 100
                    height: 100
                    label: textConstants.shutdown
                    icon: Qt.resolvedUrl("assets/shutdown.svg")
                    KeyNavigation.tab: name
                    KeyNavigation.backtab: reboot_btn
                    onClicked: sddm.powerOff()
                }

            }

        }

    }

}
