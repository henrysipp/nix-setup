import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable } from "astal"
import hyprland from "gi://AstralHyprland"

const time = Variable("").poll(1000, "date")

function Workspaces() {
    return (
        <box className="Workspaces">
            {bind(hyprland, "workspaces").as(wss => wss
                .sort((a, b) => a.id - b.id)
                .map(ws => (
                    <button className={bind(hyprland, "focusedWorkspace").as(fw => 
                        ws === fw ? "focused" : ""
                    )}>
                        {ws.id}
                    </button>
                ))
            )}
        </box>
    )

}

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        className="Bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}
        application={App}>
        <centerbox>
            <box hexpand halign={Gtk.Align.START}>
                <Workspaces />
            </box>

            <button
                onClicked="echo hello"
                halign={Gtk.Align.CENTER}
            >
                Welcome to AGS!
            </button>
            <box />
            <button
                onClicked={() => print("hello")}
                halign={Gtk.Align.CENTER}
            >
                <label label={time()} />
            </button>
        </centerbox>
    </window>
}
