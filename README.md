# vindicator
Simple app indicator for using in shell scripts written in Vala. With -Os binary size will be 20KB.

Usage:

`vindicator <path to icon without extension> <command to run on click Open>`

`vindicator /home/me/Images/icon "echo Hello"`


If you provide "UPDATE_ICON=yoursource.vala" build option, calling your update_inicator_icon()
function and then re-reading icon every 5 seconds will be enabled.

For example:

`../yoursource.vala`

```
namespace Custom {
	public static void update_indicator_icon() {
		// your stuff here
	}
}
```

`make UPDATE_ICON=../yourcode.vala VALAFLAGS="--pkg some-package" CFLAGS="-O3"`
