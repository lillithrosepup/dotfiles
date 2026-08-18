pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Services.Mpris
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.WindowManager

Scope {
    id: root

    property var curDate: new Date()
    property string nowPlaying: ""

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            root.curDate = new Date();
            var mPlayer = Mpris.players.values[0];
            if (mPlayer?.trackTitle) {
                root.nowPlaying = `${mPlayer.trackTitle} - ${mPlayer.trackArtist || "Unknown"}`;
            } else
                root.nowPlaying = "";
        }
    }

    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                required property var modelData

                screen: modelData
                implicitHeight: 32
                color: "transparent"

                anchors {
                    top: true
                    left: true
                    right: true
                }

                Rectangle {
                    anchors.fill: parent
                    color: "#1f2430"
                    border.color: "#3b4252"
                    border.width: 1
                }

                Row {
                    id: workspaces

                    spacing: 6

                    anchors {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                        leftMargin: 12
                    }

                    Component.onCompleted: {
                        console.log(Hyprland.workspaces.values.length);
                    }

                    Repeater {
                        model: Hyprland.workspaces.values

                        MouseArea {
                            id: wsMa
                            width: 24
                            height: 24

                            required property HyprlandWorkspace modelData

                            onClicked: modelData.activate()
                            acceptedButtons: Qt.LeftButton | Qt.RightButton

                            Rectangle {
                                anchors.fill: parent
                                color: "#1f2430"
                                border.color: "#3b4252"
                                border.width: 1
                            }

                            Text {
                                text: wsMa.modelData.name
                                color: "white"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }

                    MouseArea {
                        width: 24
                        height: 24

                        onClicked: Hyprland.dispatch('hl.dsp.focus({ workspace = "' + (Math.max(...Hyprland.workspaces.values.map(i => Number.parseInt(i.name))) + 1) + '"})')
                        acceptedButtons: Qt.LeftButton | Qt.RightButton

                        Rectangle {
                            anchors.fill: parent
                            color: "#1f2430"
                            border.color: "#3b4252"
                            border.width: 1
                        }

                        Text {
                            text: Math.max(...Hyprland.workspaces.values.map(i => Number.parseInt(i.name))) + 1
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }

                Text {
                    text: Hyprland.activeToplevel.title
                    anchors {
                        horizontalCenter: workspaces.horizontalCenter
                        verticalCenter: workspaces.verticalCenter
                        left: workspaces.right
                        leftMargin: 12
                    }
                    color: "white"
                }

                Text {
                    text: root.nowPlaying
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                    color: "white"
                }

                Row {
                    id: statusIndicator

                    spacing: 6

                    anchors {
                        right: timeUTC.left
                        verticalCenter: timeUTC.verticalCenter
                        rightMargin: 12
                    }

                    Repeater {
                        model: SystemTray.items.values

                        MouseArea {
                            id: iconMa

                            required property SystemTrayItem modelData

                            onClicked: event => {
                                if (event.button === Qt.LeftButton)
                                    modelData.activate();
                                else
                                    modelData.hasMenu ? menu.open() : modelData.secondaryActivate();
                            }
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            width: 24
                            height: 24

                            QsMenuAnchor {
                                id: menu

                                menu: iconMa.modelData.menu

                                anchor {
                                    adjustment: PopupAdjustment.ResizeY | PopupAdjustment.SlideX
                                    item: iconMa
                                    gravity: Edges.Bottom
                                    edges: Edges.Bottom
                                }
                            }

                            IconImage {
                                function getTrayIcon(id: string, icon: string): string {
                                    console.log("Input", id, icon);
                                    if (icon.includes("?path=")) {
                                        const [name, path] = icon.split("?path=");
                                        const file = name.slice(name.lastIndexOf("/") + 1);
                                        console.log("File", file);
                                        const themed = false; //Quickshell.iconPath(file, true);
                                        console.log("Themed", themed);
                                        icon = themed ? themed : Qt.resolvedUrl(`${path}/${file}`);
                                    }
                                    console.log("Returning icon", icon);
                                    return icon;
                                }

                                anchors.fill: parent
                                source: getTrayIcon(iconMa.modelData.id, iconMa.modelData.icon)
                            }
                        }
                    }
                }

                // RST
                Text {
                    id: timeUTC

                    text: root.curDate.getUTCHours() % 12 + ":" + String(root.curDate.getUTCMinutes()).padStart(2, "0") + " " + (root.curDate.getUTCHours() >= 12 ? "PM" : "AM") + " RST (Rose Std. Time)"
                    color: "white"
                    font.pixelSize: 12

                    anchors {
                        right: timeEST.left
                        verticalCenter: timeEST.verticalCenter
                        rightMargin: 12
                    }
                }

                Text {
                    id: timeEST

                    text: root.curDate.getHours() % 12 + ":" + String(root.curDate.getMinutes()).padStart(2, "0") + " " + (root.curDate.getHours() >= 12 ? "PM" : "AM")
                    color: "white"
                    font.pixelSize: 12

                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                        rightMargin: 12
                    }
                }
            }
        }
    }
}
