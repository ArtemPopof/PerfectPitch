using Gst;

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
* Authored by: Artem Popov <artempopovserg@gmail.com>
*/
public class Player {
    private MainLoop loop = new MainLoop ();

    public void init (string[] args) {
        Gst.init (ref args);
    }

    public void play_file (string file_name) {
        dynamic Element play = ElementFactory.make ("playbin", "play");
        
        try {
            play.uri = Gst.filename_to_uri (file_name);
        } catch (Error e) {
            warning (e.message);
        }

        Gst.Bus bus = play.get_bus ();
        bus.add_watch (0, bus_callback);
        
        play.set_state (State.PLAYING);

        loop.run ();
    }

    private bool bus_callback (Gst.Bus bus, Message message) {
        switch (message.type) {
        case MessageType.ERROR:
            processError (message);
            break;
        case MessageType.EOS:
            stdout.printf ("End of Stream\n");
            break;
        case MessageType.STATE_CHANGED:
            processStateChanged (message);
            break;
        case MessageType.TAG:
            stdout.printf ("TAGLIST found\n");
            break;
        default:
            break;
        }

        return true;
    }

    private void processError(Message message) {
        GLib.Error e;
        string debug;
        message.parse_error (out e, out debug);
        stdout.printf ("Error: %s\n", e.message);
        stdout.printf ("Debug: %s\n", debug);
        loop.quit ();
    }

    private void processStateChanged (Message message) {
        //stdout.printf ("State changed!\n");
    }

    public void set_volume (double volume) {
        //playbin.set_property ("volume", volume);
    }

}
