import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

ShellRoot {
    PanelWindow {
        id: w

        implicitWidth: 504
        implicitHeight: 48
        color: "transparent"

        anchors {
            left: true
            top: true
        }

        Image {
            source: "unregistered.png"
            width: w.implicitWidth
            height: w.implicitHeight
        }

        // Give the window an empty click mask so all clicks pass through it.
        mask: Region {}
    }
}
