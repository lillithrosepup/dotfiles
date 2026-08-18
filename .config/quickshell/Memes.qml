import "./memes"
import Quickshell
import Quickshell.Io

ShellRoot {
    id: root

    property bool enabled: false

    IpcHandler {
        target: "memes"

        function toggle(): void {
            root.enabled = !root.enabled;
        }

        function enable(): void {
            root.enabled = true;
        }

        function disable(): void {
            root.enabled = false;
        }
    }

    Variants {
        model: root.enabled ? Quickshell.screens : []

        PanelWindow {
            color: "transparent"

            Hypercam {}

            Stock {}
            ActivateLinux {}
        }
    }
}
