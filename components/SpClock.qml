import QtQuick 2.0

Item {
    id: sp_clock

    property date value: new Date()
    property color tColor: "white"

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: sp_clock.value = new Date()
    }

    Text {
        id: sp_clock_time

        x: 0
        y: 0
        text: Qt.formatDateTime(sp_clock.value, "HH:mm AP")
        color: sp_clock.tColor
        font.pixelSize: 48
        fontSizeMode: Text.VerticalFit
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: sp_clock_date

        x: 0
        y: 80
        text: Qt.formatDateTime(sp_clock.value, "dddd, dd MMMM yyyy")
        color: sp_clock.tColor
        font.pixelSize: 24
        anchors.horizontalCenter: parent.horizontalCenter
    }

}
