import { App } from "astal/gtk3";
import style from "./style.scss";
import { Bar } from "./widget/index";

App.start({
  css: style,
  main() {
    App.get_monitors().map(Bar);
  },
});
