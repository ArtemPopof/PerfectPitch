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
public class TimerWidget : Gtk.Label {

    private int seconds_left;
    private TimerCallback callback;
    private bool is_running;

    public TimerWidget () {
        label = "0";
        get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
    }
    
    private void decrement_time () {
        set_time (--seconds_left);
    }
    
    public void set_time (int seconds) {
        seconds_left = seconds;
        label = @"$seconds";
    }
    
    public void set_callback (TimerCallback callback) {
        this.callback = callback;
    }
    
    public void start () {
        is_running = true;
        Thread.create<void> (run, true);
    }
    
    public void stop () {
        is_running = false;
    }
    
    public void run () {
        while (is_running && seconds_left > 0) {
            decrement_time ();
            Thread.usleep (1000000);
        }
    }
      
}
