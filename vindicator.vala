using AppIndicator;
#if UPDATE_ICON
using Custom;
#endif

public async void nap (uint interval, int priority = GLib.Priority.DEFAULT) {
	GLib.Timeout.add (interval, () => {
		nap.callback ();
		return false;
	}, priority);
	yield;
}

public async void update_icon(Indicator indicator, string iconFilename, string iconPath) {
	indicator.set_icon_theme_path(iconPath);
	string n = "0";
	#if UPDATE_ICON
	while(true) {
		update_indicator_icon(); // custom function call
	#endif
		indicator.set_status(IndicatorStatus.PASSIVE);
		indicator.set_icon_full(iconFilename, n);
		indicator.set_status(IndicatorStatus.ACTIVE);
	#if UPDATE_ICON
		n = (int.parse (n) + 1).to_string();
		yield nap(5000);
	}
	#endif
}

public class Applet {
        public static int main(string[] args) {
		if (args[1] == "--help") {
			print("Usage:\n");
			print("vindicator <path to icon without extension> <command to run on click Open>\n");
			return 0;
		}

                Gtk.init(ref args);

		var iconPath = Path.get_dirname(args[1]);
		var iconFilename = Path.get_basename(args[1]);

                var indicator = new Indicator("App", iconFilename, IndicatorCategory.HARDWARE);
		
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
