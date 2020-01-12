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
public class Application : Gtk.Application, UiGameListener {

    private const int ANSWER_OPTIONS_COUNT = 5;

    private Player player;
    private MainController controller;
    
    private Gtk.Label[] frequency_options = new Gtk.Label[ANSWER_OPTIONS_COUNT];

    Application (Player player) {
        Object (
            application_id: "com.github.artempopof.perfectpitch",
            flags: ApplicationFlags.FLAGS_NONE
        );

        this.player = player;
        this.controller = new MainController (this);
    }

    public void game_started (string[] wrong_frequencies) {
        for (int i = 0; i < ANSWER_OPTIONS_COUNT; i++) {
            frequency_options[i].label = wrong_frequencies[i];
        }
    }

    // TODO refactor
    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.title = _("PerfectPitch");
        configure_styles ();

        main_window.default_width = 600;
        main_window.default_height = 400;
        main_window.resizable = false;

        var content_panel = new Gtk.Box (Gtk.VERTICAL, 2);

        var how_to_message = new Granite.Widgets.Welcome ((_("Guess boosted frequency")), (_("Peaking (Bell) EQ filter is being used to boost a certain frequency range. You need to guess boosted frequency. Use the EQ on/off buttons to compare the equalized and non equalized sounds.")));
        how_to_message.valign = Gtk.CENTER;
        how_to_message.append ("text-x-vala", "Start", _("Try to guess boosted frequency"));
        
        // how to 
        var header_message = new Gtk.Box (Gtk.VERTICAL, 2);
        var header_title = new Gtk.Label (_("Guess boosted frequency"));
        header_title.justify = Gtk.Justification.CENTER;
        header_title.hexpand = true;
        header_title.get_style_context ().add_class (Granite.STYLE_CLASS_H1_LABEL);
        var header_description = new Gtk.Label (_("Peaking (Bell) EQ filter is being used to boost a certain frequency range. You need to guess boosted frequency. Use the EQ on/off buttons to compare the equalized and non equalized sounds."));
        header_description.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
        header_description.get_style_context ().add_class (Gtk.STYLE_CLASS_DIM_LABEL);

        header_description.justify = Gtk.Justification.CENTER;
        header_description.hexpand = true;
        header_description.wrap = true;
        header_description.wrap_mode = Pango.WrapMode.WORD;

        header_message.add (header_title);
        header_message.add (header_description);        
        header_message.margin_top = 40;
        header_message.margin_bottom = 40;

        // start button
        var start_button = new Gtk.Button.with_label (_("Start"));
        start_button.halign = Gtk.CENTER;
        start_button.valign = Gtk.START;
        start_button.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

        // freq cards
        var guess_variants = new Gtk.Grid ();
        guess_variants.halign = Gtk.CENTER;

        for (int i = 0; i < ANSWER_OPTIONS_COUNT; i++) {
            var label = create_option_card (guess_variants);
            frequency_options[i] = label;
        }

        // eq panel
        var eq_panel = new Gtk.Box (Gtk.HORIZONTAL, 2);
        eq_panel.halign = Gtk.Align.CENTER;
        eq_panel.margin_bottom = 20;

        var eq_switch_label = new Gtk.Label (_("EQ"));
        eq_switch_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
        eq_switch_label.margin_end = 12;
        var eq_switch = new Gtk.Switch ();
        eq_switch.active = true;
        
        eq_panel.add (eq_switch_label);
        eq_panel.add (eq_switch);

        // after start panel
        var after_start_panel = new Gtk.Box (Gtk.VERTICAL, 2);
        after_start_panel.add (eq_panel);
        after_start_panel.add (guess_variants);
        after_start_panel.valign = Gtk.START;

        content_panel.get_style_context ().add_class (Granite.STYLE_CLASS_CARD);
        content_panel.add (header_message);
        content_panel.add (start_button);
        content_panel.add (after_start_panel);

        main_window.add (content_panel);

        main_window.show_all ();

        after_start_panel.visible = false;

        start_button.clicked.connect (() => {
            start_button.visible = false;
            after_start_panel.visible = true;            
            controller.start_game ();
            player.play_file ("sounds/bensound-jazzyfrenchy.mp3");
        });
    }

    private Gtk.Label create_option_card (Gtk.Container parent) {
        var event_box = new Gtk.EventBox ();
        event_box.margin_bottom = 10;
        var card = new Gtk.Frame (null);
        card.margin_end = 20;

        event_box.add (card);

        var variant_label = new Gtk.Label (_("440 Hz"));
        variant_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);
        variant_label.margin = 20;

        card.add (variant_label);
        parent.add (event_box);

        event_box.button_press_event.connect ((sender, event) => {
            controller.user_clicked (variant_label.label);
            card.get_style_context ().add_class ("guess_card_wrong");
            return true;
        });

        return variant_label;
    }

    public static int main (string[] args) {
        var player = new Player ();
        player.init (args);

        var app = new Application (player);
        return app.run (args);
    }

    private static void configure_styles () {
        var css_provider = new Gtk.CssProvider ();
        try {
            css_provider.load_from_path ("css/main.css");
        } catch (Error error) {
            warning ("style configuration failed: %s", error.message);
        }
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER); 
   }
}
