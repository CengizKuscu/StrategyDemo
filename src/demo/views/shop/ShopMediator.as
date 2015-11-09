/**
 * Created by Cengiz on 6.11.2015.
 */
package demo.views.shop
{
import demo.models.vo.BuildingTypeVO;
import demo.signals.ui.ShopItemSelectedSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ShopMediator extends Mediator
{
    [Inject]
    public var view:ShopView;

    [Inject]
    public var shopItemSelectedSignal:ShopItemSelectedSignal;

    override public function initialize():void
    {
        view.itemSelected.add(onItemSelected);
    }


    override public function destroy():void
    {
        view.itemSelected.remove(onItemSelected);
    }

    private function onItemSelected(typeVo:BuildingTypeVO):void
    {
        shopItemSelectedSignal.dispatch(typeVo);
    }
}
}
