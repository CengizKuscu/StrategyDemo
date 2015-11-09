/**
 * Created by Cengiz on 8.11.2015.
 */
package demo.views.itempopup
{
import demo.game.GridItem;
import demo.signals.game.UnBuildSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ItemPopupMediator extends Mediator
{
    [Inject]
    public var view:ItemPopupView;

    [Inject]
    public var unBuildSignal:UnBuildSignal;

    override public function initialize():void
    {
        view.unBuildSignal.add(onUnBuild);
    }

    override public function destroy():void
    {
        view.unBuildSignal.remove(onUnBuild);
    }

    private function onUnBuild(gridItem:GridItem):void
    {
        unBuildSignal.dispatch(gridItem);
    }
}
}
