using Gst;

public class Player {
    private MainLoop loop = new MainLoop ();

    public void init (string[] args) {
        Gst.init (ref args);
    }

    public void play_file (string file_name) {
        dynamic Element play = ElementFactory.make ("playbin", "play");
        play.uri = Gst.filename_to_uri (file_name);

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
        GLib.Error err;
        string debug;
        message.parse_error (out err, out debug);
        stdout.printf ("Error: %s\n", err.message);
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
