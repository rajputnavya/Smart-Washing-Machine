import QtQuick
// import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Effects //for glow effect

RadioButton { //inheriting RadioButton, so that its properties may remain intact
    id: radioButton
    font.pixelSize: 18
    font.family: "Arial"
    font.bold: false

    indicator: Rectangle {
        id: indicatorRect
        x: 0
        y: parent.height / 2 - height / 2
        width: 26
        height: 26
        radius: width / 2
        color: "transparent"
        border.color: radioButton.checked ? "yellowgreen" : "gray"
        border.width: 2

        // Inner fill circle
        Rectangle {
            id: innerCircle
            anchors.centerIn: parent
            width: 16
            height: 16
            radius: width / 2
            color: radioButton.checked ? "yellowgreen" : "gray"
        }

        // GLOW EFFECT
        MultiEffect {
            anchors.fill: innerCircle
            source: innerCircle
            visible: radioButton.checked
            shadowEnabled: true
            shadowBlur: 1.0
            shadowColor: "yellowgreen"
            shadowHorizontalOffset: 0 //glow should surround equally
            shadowVerticalOffset: 0
        }
    }

    contentItem: Text {
        text: radioButton.text
        font: radioButton.font
        color: "white"
        verticalAlignment: Text.AlignVCenter
        leftPadding: 32
    }
}