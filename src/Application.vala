/*
* Copyright (c) 2019-2020 ArtemPopof
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Artem Popov <ArtemPopovSerg@gmail.com>
*/
public class Application : Gtk.Application {

    private Player player;

    Application (Player player) {
        Object (
            application_id: "com.github.ArtemPopof.PerfectPitch",
            flags: ApplicationFlags.FLAGS_NONE
        );

        this.player = player;
    }

    // TODO refactor
    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.title = "PerfectPitch";

        main_window.default_width = 600;
        main_window.default_height = 300;
        main_window.resizable = false;

        var content_panel = new Gtk.Grid ();
        content_panel.orientation = Gtk.VERTICAL;

        var how_to_message = new Granite.Widgets.Welcome (("Guess boosted frequency"), ("Peaking (Bell) EQ filter is being used to boost a certain frequency range. You need to guess boosted frequency. Use the EQ on/off buttons to compare the equalized and non equalized sounds."));

        // start button
        var start_button = new Gtk.Button.with_label ("Start");
        start_button.margin_start = 20;
        start_button.margin_end = 20;
        start_button.preferred_width = 100;
        start_button.clicked.connect (() => {
            player.play_file ("res/bensound-jazzyfrenchy.mp3");
        });

        // eq panel
        var eq_panel = new Gtk.Grid ();
        eq_panel.halign = Gtk.Align.CENTER;
        eq_panel.margin_bottom = 12;

        var eq_switch_label = new Gtk.Label ("EQ");
        eq_switch_label.get_style_context(). add_class (Granite.STYLE_CLASS_H2_LABEL);
        eq_switch_label.margin_end = 12;
        var eq_switch = new Gtk.Switch ();
        eq_panel.add (eq_switch_label);
        eq_panel.add (eq_switch);

        content_panel.get_style_context ().add_class (Granite.STYLE_CLASS_CARD);
        content_panel.add (how_to_message);
        content_panel.add (start_button);
        content_panel.add (eq_panel);

        main_window.add (content_panel);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        var player = new Player ();
        player.init (args);
        //player.set_volume (0.1);

        return new Application (player).run (args);
    }
}
