import GUI.TabbedPane;

import javax.swing.*;

/**
 * Created by Sheepsheep on 2016-06-12.
 */
public class main {
    public static void main(String[] args) {
        JFrame frame = new JFrame("TabbedPane");
        frame.setContentPane(new TabbedPane().rootpanel);

        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);



        frame.pack();
        frame.setVisible(true);

    }

}

