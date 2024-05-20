import "./components"
import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: container

    property int sessionIndex: session.index

    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true
    Component.onCompleted: {
        if (name.text == "")
            name.focus = true;
        else
            password.focus = true;
    }

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

    Background {
        id: background_image

        anchors.fill: parent
        source: Qt.resolvedUrl(config.background)
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: background_color

        color: "black"
        width: 500
        height: parent.height
        anchors.right: parent.right
        anchors.top: parent.top

        Grid {
            width: parent.width
            height: parent.height
            columns: 1
            spacing: 6

            Rectangle {
                id: clock

                color: "black"
                width: parent.width
                height: parent.height * 0.2

                Row {
                    width: parent.width
                    height: parent.height
                    y: parent.height * 0.4

                    SpClock {
                        width: parent.width
                        height: parent.height
                    }

                }

            }

            Rectangle {
                id: form

                color: "black"
                width: parent.width
                height: parent.height * 0.5

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 12

                    Rectangle {
                        width: 300
                        height: 60
                        color: "black"

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
                        color: "black"

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

                            radius: 4
                            width: parent.width
                            height: 40
                            anchors.bottom: parent.bottom
                            font.pixelSize: 18
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

                    Rectangle {
                        width: 300
                        height: 60
                        color: "black"

                        Button {
                            id: login

                            radius: 4
                            width: parent.width
                            height: 40
                            anchors.bottom: parent.bottom
                            text: textConstants.login
                            color: "white"
                            textColor: "black"
                            borderColor: "white"
                            pressedColor: "white"
                            activeColor: "white"
                            KeyNavigation.tab: maya_reboot
                            KeyNavigation.backtab: maya_layout
                            onClicked: sddm.login(name.text, password.text, sessionIndex)
                        }

                    }

                }

            }

            Rectangle {
                id: actions

                color: "black"
                width: parent.width
                height: parent.height * 0.3
            }

        }

    }

}
