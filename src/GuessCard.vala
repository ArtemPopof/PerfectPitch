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
public class GuessCard: GLib.Object {
    private Gtk.Frame _container;
    private Gtk.Label _label;
    private Gtk.EventBox _event_box;
    
    public Gtk.Frame container {
        get { return _container; }
        set { _container = value; }
    }
    
    public Gtk.Label label {
        get { return _label; }
        set { _label = value; }
    }
    
    public string text {
        get { return _label.label; }
        set { _label.label = value; }
    }
    
    public Gtk.EventBox event_box {
        get { return _event_box; }
        set { _event_box = value; }
    }
}
