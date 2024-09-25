import QtQuick 2.0

Item {
    // States and associated visual attributes
    // Behavior on state transitions
    // Area to react to mouse actions

    id: sp_button

    property bool enabled: true
    property alias icon: sp_button_icon.source
    property alias label: sp_button_label.text
    property alias font: sp_button_label.font
    property color iconColor: "#aaaaaa"
    property color labelColor: "#424242"
    property color hoverIconColor: "#cccccc"
    property color hoverLabelColor: "#808080"
    property color pressIconColor: "#dcdcdc"
    property color pressLabelColor: "#a0a0a0"
    property color disableColor: "#888888"

    signal pressed()
    signal released()
    signal clicked()

    states: [
        State {
            name: "disabled"
            when: (sp_button.enabled === false)

            PropertyChanges {
                target: sp_button_bg
                color: disableColor
            }

            PropertyChanges {
                target: sp_button_label
                color: disableColor
            }

        },
        State {
            name: "hover"

            PropertyChanges {
                target: sp_button_label
                color: hoverLabelColor
            }

            PropertyChanges {
                target: sp_button_bg
                color: hoverIconColor
            }

        },
        State {
            name: "pressed"

            PropertyChanges {
                target: sp_button_label
                color: hoverLabelColor
            }

            PropertyChanges {
                target: sp_button_bg
                color: pressIconColor
            }

        }
    ]
    transitions: [
        Transition {
            from: ""
            to: "hover"

            ColorAnimation {
                duration: 250
            }

        },
        Transition {
            from: ""
            to: "pressed"

            ColorAnimation {
                duration: 25
            }

        },
        Transition {
            from: "disabled"
            to: "enabled"

            ColorAnimation {
                duration: 50
            }

        },
        Transition {
            from: "enabled"
            to: "disabled"

            ColorAnimation {
                duration: 50
            }

        }
    ]

    Row {
        x: 4
        y: 4
        spacing: 8

        Rectangle {
            id: sp_button_bg

            width: 80
            height: 100
            radius: 20
            color: iconColor

            Image {
                id: sp_button_icon

                width: 60
                height: 60
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
            }

            Text {
                id: sp_button_label

                height: 40
                anchors.bottom: parent.bottom
                text: ""
                color: labelColor
                font.pixelSize: 16
                font.weight: Font.DemiBold
                fontSizeMode: Text.VerticalFit
                horizontalAlignment: parent.AlignRight
                verticalAlignment: parent.AlignVCenter
            }

        }

    }

    MouseArea {
        anchors.fill: sp_button
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton
        onEntered: {
            sp_button.state = "hover";
        }
        onExited: {
            sp_button.state = "";
        }
        onPressed: {
            sp_button.state = "pressed";
        }
        onClicked: {
            sp_button.clicked();
        }
        onReleased: {
            if (containsMouse)
                sp_button.state = "hover";
            else
                sp_button.state = "";
        }
    }

}
