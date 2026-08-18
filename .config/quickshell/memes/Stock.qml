import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

ShellRoot {
    PanelWindow {
        id: w

        implicitWidth: 1920
        implicitHeight: 1080
        color: "transparent"

        anchors {
            left: true
            top: true
        }

        Image {
            source: "stock.png"
            width: w.implicitWidth
            height: w.implicitHeight
        }

        // Give the window an empty click mask so all clicks pass through it.
        mask: Region {}
    }
}
