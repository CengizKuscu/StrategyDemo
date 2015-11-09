/**
 * Created by Cengiz on 9.11.2015.
 */
package demo.signals.game
{
import flash.utils.Dictionary;

import org.osflash.signals.Signal;

public class SaveDataSignal extends Signal
{
    public function SaveDataSignal()
    {
        super(Dictionary);
    }
}
}
