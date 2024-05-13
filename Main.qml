import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
  id: container

  Background {
    anchors.fill: parent
    source: config.background
    fillMode: Image.PreserveAspectCrop

    onStatusChanged: {
        if (status == Image.Error && source != config.defaultBackground) {
            source = config.defaultBackground
        }
    }
  }
}
