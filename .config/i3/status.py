from i3pystatus import  Status

status = Status(standalone=True)
status.register("clock", format="%a %-d %b %X", on_click="zenity --calendar")

status.register("temp",  format="{temp:.0f}°C")

status.register("pulseaudio",
format="Volume: {volume_bar} {volume}% ({db})",
color_muted="#FF0000",
color_unmuted="#FFFFFF",
bar_type="horizontal")

status.run()
