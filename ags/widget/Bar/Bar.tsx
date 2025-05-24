import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable } from "astal";
import { Workspaces } from "./modules/Workspaces";

const time = Variable("").poll(1000, "date");

export function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      className="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox>
        <box hexpand halign={Gtk.Align.START}>
          <Workspaces />
        </box>

        <box hexpand halign={Gtk.Align.CENTER} />

        <box hexpand halign={Gtk.Align.END}>
          <button>
            <label label={time()} />
          </button>
        </box>
      </centerbox>
    </window>
  );
}
