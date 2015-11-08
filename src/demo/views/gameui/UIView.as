/**
 * Created by Cengiz on 6.11.2015.
 */
package demo.views.gameui
{
import demo.models.IAssetProvider;

import org.osflash.signals.Signal;

import starling.display.Button;

import starling.display.Sprite;
import starling.events.Event;

public class UIView extends Sprite
{
    private var mAssetProvider:IAssetProvider;
    private var mZoomOutButton:Button;
    private var mZoomInButton:Button;
    private var mShopButton:Button;

    public var zoomIn:Signal = new Signal();
    public var zoomOut:Signal = new Signal();
    public var openShop:Signal = new Signal();

    public function UIView(assetProvider:IAssetProvider)
    {
        mAssetProvider = assetProvider;

        mShopButton = new Button(mAssetProvider.getTexture("blue_button00.png"), "Buildings");
        mShopButton.x = 10;
        mShopButton.y = 610;
        mShopButton.addEventListener(Event.TRIGGERED, onShopBtnTrigger);
        addChild(mShopButton);

        mZoomOutButton = new Button(mAssetProvider.getTexture("zoomout.png"));
        mZoomOutButton.x = 900;
        mZoomOutButton.y = 660;
        mZoomOutButton.addEventListener(Event.TRIGGERED, onZoomOutTrigger);
        mZoomOutButton.width = 32;
        mZoomOutButton.height = 32;
        addChild(mZoomOutButton);

        mZoomInButton = new Button(mAssetProvider.getTexture("zoomin.png"));
        mZoomInButton.x = 900;
        mZoomInButton.y = 610;
        mZoomInButton.addEventListener(Event.TRIGGERED, onZoomInTrigger);
        mZoomInButton.width = 32;
        mZoomInButton.height = 32;
        addChild(mZoomInButton);
    }

    private function onShopBtnTrigger(e:Event):void
    {
        openShop.dispatch();
    }

    private function onZoomInTrigger(e:Event):void
    {
        zoomIn.dispatch();
    }

    private function onZoomOutTrigger(e:Event):void
    {
        zoomOut.dispatch();
    }

    override public function dispose():void
    {
        /*mShopButton.removeEventListeners();
         mShopButton = null;
         openShop.removeAll();*/
        super.dispose();

    }
}
}
