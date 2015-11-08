/**
 * Created by Cengiz on 8.11.2015.
 */
package demo.signals
{
import demo.game.GridItem;
import demo.models.vo.BuildingTypeVO;

import org.osflash.signals.Signal;

public class UnBuildSignal extends Signal
{
    public function UnBuildSignal()
    {
        super(GridItem);
    }
}
}
