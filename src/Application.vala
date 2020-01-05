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

    Application () {
        Object (
            application_id: "com.github.ArtemPopof.PerfectPitch",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_width = 600;
        main_window.default_height = 300;
        main_window.title = "PerfectPitch";

        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new Application ().run (args);
    }
}
