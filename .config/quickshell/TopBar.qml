pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Services.Mpris
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.WindowManager

Scope {
    id: root

    property date curDate: new Date()
    property string nowPlaying: ""

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            root.curDate = new Date();
            var mPlayer = Mpris.players.values.find(i => ["astra", "spotify"].includes(i.identity.toLowerCase()));
            if (mPlayer?.trackTitle) {
                root.nowPlaying = `${mPlayer.trackTitle} - ${mPlayer.trackArtist || "Unknown"}`;
            } else
                root.nowPlaying = "";
        }
    }

    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow { // qmllint disable uncreatable-type
                id: panel
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
                    color: "#2d212d"
                    border.color: "#211921"
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
                        model: Hyprland.workspaces.values.filter(ws => ws.monitor.name === panel.modelData.name)

                        MouseArea {
                            id: wsMa
                            width: Math.max(wsText.width + 12, 24)
                            height: 24

                            required property HyprlandWorkspace modelData

                            onClicked: modelData.activate()
                            acceptedButtons: Qt.LeftButton | Qt.RightButton

                            Rectangle {
                                anchors.fill: parent
                                color: wsMa.modelData.monitor.name === panel.modelData.name && wsMa.modelData.active ? "#241a24" : "#3c2c3c"
                                border.color: "#211921"
                                border.width: 1
                            }

                            Text {
                                id: wsText
                                text: wsMa.modelData.name
                                color: "white"
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }

                    MouseArea {
                        id: nextMa
                        width: Math.max(nextText.width + 12, 24)
                        height: 24

                        function getMaxWorkspace() {
                            return Math.max(...Hyprland.workspaces.values.map(i => i.id));
                        }

                        onClicked: Hyprland.dispatch('hl.dsp.focus({ workspace = "' + (getMaxWorkspace() + 1) + '"})')
                        acceptedButtons: Qt.LeftButton | Qt.RightButton

                        Rectangle {
                            anchors.fill: parent
                            color: '#3c2c3c'
                            border.color: "#211921"
                            border.width: 1
                        }

                        Text {
                            id: nextText
                            text: nextMa.getMaxWorkspace() + 1
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
                        right: clocks.left
                        verticalCenter: clocks.verticalCenter
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

                GridLayout {
                    id: clocks
                    flow: GridLayout.LeftToRight

                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                        rightMargin: 12
                    }

                    Repeater {
                        model: [
                            {
                                offset: 2,
                                color: "#335533",
                                shortId: "b"
                            },
                            {
                                offset: 1,
                                color: '#b055ff',
                                shortId: "ru"
                            },
                            {
                                offset: 0,
                                color: "#ff5577",
                                shortId: "ro"
                            },
                            {
                                offset: -4,
                                shortId: ""
                            },
                        ]

                        Text {
                            required property var modelData

                            color: modelData.color ?? "white"
                            font.pixelSize: 12

                            function formatTime(date, offset, shortId) {
                                var d = new Date(date.getTime() + offset * 3600000);

                                var hours = d.getUTCHours();
                                var minutes = d.getUTCMinutes();

                                var ampm = hours >= 12 ? "PM" : "AM";

                                hours %= 12;
                                if (hours === 0)
                                    hours = 12;

                                return hours + ":" + String(minutes).padStart(2, "0") + " " + shortId + ampm;
                            }

                            text: formatTime(root.curDate, modelData.offset, modelData.shortId)
                        }
                    }
                }
            }
        }
    }
}
