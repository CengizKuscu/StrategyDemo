/**
 * Created by Cengiz on 8.11.2015.
 */
package demo.signals.game
{
import demo.game.GridItem;

import org.osflash.signals.Signal;

public class UnBuildSignal extends Signal
{
    public function UnBuildSignal()
    {
        super(GridItem);
    }
}
}
