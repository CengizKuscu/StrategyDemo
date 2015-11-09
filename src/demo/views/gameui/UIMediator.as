/**
 * Created by Cengiz on 6.11.2015.
 */
package demo.views.gameui
{
import demo.signals.ui.OpenShopViewSignal;
import demo.signals.ui.ZoomInSignal;
import demo.signals.ui.ZoomOutSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class UIMediator extends Mediator
{
    [Inject]
    public var view:UIView;

    [Inject]
    public var zoomIn:ZoomInSignal;

    [Inject]
    public var zoomOut:ZoomOutSignal;

    [Inject]
    public var openShopView:OpenShopViewSignal;

    public function UIMediator()
    {
        super();
    }

    override public function initialize():void
    {
        view.zoomIn.add(zoomIn.dispatch);
        view.zoomOut.add(zoomOut.dispatch);
        view.openShop.add(openShopView.dispatch);
    }


    override public function destroy():void
    {
        view.zoomIn.remove(zoomIn.dispatch);
        view.zoomOut.remove(zoomOut.dispatch);
        view.openShop.remove(openShopView.dispatch);
    }
}
}
