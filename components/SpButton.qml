import QtQuick 2.0

Item {
    // States and associated visual attributes
    // Behavior on state transitions
    // Area to react to mouse actions

    id: sp_button

    property bool enabled: true
    property alias icon: sp_button_icon.source
    property alias label: sp_button_label.text
    property color iconColor: "#000000"
    property color labelColor: "#ffffff"
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

        }
    ]
    transitions: [
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
            height: 90
            color: iconColor

            Image {
                id: sp_button_icon

                width: 50
                height: 50
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: sp_button_label

                height: 40
                text: ""
                color: labelColor
                font.pixelSize: 12
                font.weight: Font.DemiBold
                fontSizeMode: Text.VerticalFit
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
            }

        }

    }

    MouseArea {
        anchors.fill: sp_button
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton
        onExited: {
            sp_button.state = "";
        }
        onClicked: {
            sp_button.clicked();
        }
    }

}
