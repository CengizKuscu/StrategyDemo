/**
 * Created by Cengiz on 6.11.2015.
 */
package demo.signals
{
import demo.models.vo.BuildingTypeVO;

import org.osflash.signals.Signal;

public class ShopItemSelectedSignal extends Signal
{
    public function ShopItemSelectedSignal()
    {
        super(BuildingTypeVO);
    }
}
}
