/**
 * Created by Cengiz on 8.11.2015.
 */
package demo.signals.game
{
import demo.game.GridItem;

import org.osflash.signals.Signal;

public class OpenItemPopupSignal extends Signal
{
    public function OpenItemPopupSignal()
    {
        super(String, GridItem);
    }
}
}
