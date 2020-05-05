using AppIndicator;

public async void nap (uint interval, int priority = GLib.Priority.DEFAULT) {
	GLib.Timeout.add (interval, () => {
		nap.callback ();
		return false;
	}, priority);
	yield;
}

public async void update_icon(Indicator indicator, string iconFilename, string iconPath) {
	indicator.set_icon_theme_path(iconPath);
	while(true) {
		indicator.set_icon_full("process-working", "none");
		indicator.set_icon_full(iconFilename, "none");
		yield nap(5000);
	}
}

public class Applet {
        public static int main(string[] args) {
                Gtk.init(ref args);

		var iconPath = Path.get_dirname(args[1]);
		var iconFilename = Path.get_basename(args[1]);

                var indicator = new Indicator("App", iconFilename, IndicatorCategory.APPLICATION_STATUS);

		// indicator.set_icon_theme_path(iconPath);
		indicator.set_status(IndicatorStatus.ACTIVE);
		
                var menu = new Gtk.Menu();

                var item = new Gtk.MenuItem.with_label("Open...");
                item.activate.connect(() => {
                        Process.spawn_command_line_sync(args[2]);
                });
                item.show();
                menu.append(item);

                indicator.set_menu(menu);
		update_icon(indicator, iconFilename, iconPath);
                Gtk.main();
                return 0;
        }
}
