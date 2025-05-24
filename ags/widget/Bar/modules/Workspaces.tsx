import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { bind, Variable } from "astal";
import AstralHyprland from "gi://AstalHyprland?version=0.1";


const hyprland = AstralHyprland.get_default()
export function Workspaces() {
  return (
    <box className="Workspaces">
      {bind(hyprland, "workspaces").as((wss) =>
        wss
          .sort((a, b) => a.id - b.id)
          .map((ws) => (
            <button
              className={bind(hyprland, "focusedWorkspace").as((fw) =>
                ws === fw ? "focused" : ""
              )}
            >
              {ws.id}
            </button>
          ))
      )}
    </box>
  );
}
