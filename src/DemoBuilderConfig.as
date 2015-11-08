/**
 * Created by Cengiz on 5.11.2015.
 */
package
{
import demo.commands.BuyItemCMD;
import demo.commands.LoadAssestsCMD;
import demo.commands.LoadGameDataCMD;
import demo.commands.OpenItemPopupCMD;
import demo.commands.OpenShopViewCMD;
import demo.commands.PrepGameViewCMD;
import demo.commands.UnBuildCMD;
import demo.commands.ZoomInCMD;
import demo.commands.ZoomOutCMD;
import demo.models.AssetModel;
import demo.models.GameDataModel;
import demo.models.IAssetProvider;
import demo.signals.LoadAssetsSignal;
import demo.signals.LoadGameDataSignal;
import demo.signals.OpenItemPopupSignal;
import demo.signals.OpenShopViewSignal;
import demo.signals.PrepGameViewSignal;
import demo.signals.ShopItemSelectedSignal;
import demo.signals.UnBuildSignal;
import demo.signals.ZoomInSignal;
import demo.signals.ZoomOutSignal;
import demo.views.gameui.UIMediator;
import demo.views.gameui.UIView;
import demo.views.itempopup.ItemPopupMediator;
import demo.views.itempopup.ItemPopupView;
import demo.views.shop.ShopMediator;
import demo.views.shop.ShopView;

import flash.events.IEventDispatcher;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.contextView.ContextView;

import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;

import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

import starling.core.Starling;

public class DemoBuilderConfig implements IConfig
{
    public static const GAME_DATA_URL:String = "data/gamedata.xml";

    [Inject]
    public var injector:IInjector;

    [Inject]
    public var mediatorMap:IMediatorMap;

    [Inject]
    public var commandMap:IEventCommandMap;

    [Inject]
    public var contextView:ContextView;

    [Inject]
    public var signalCommandMap:ISignalCommandMap;

    [Inject]
    public var starling:Starling;

    [Inject]
    public var eventDispatcher:IEventDispatcher;

    public function configure():void
    {
        signalCommandMap.map(LoadGameDataSignal).toCommand(LoadGameDataCMD);
        signalCommandMap.map(LoadAssetsSignal).toCommand(LoadAssestsCMD);
        signalCommandMap.map(PrepGameViewSignal).toCommand(PrepGameViewCMD);

        signalCommandMap.map(ZoomInSignal).toCommand(ZoomInCMD);
        signalCommandMap.map(ZoomOutSignal).toCommand(ZoomOutCMD);

        signalCommandMap.map(OpenShopViewSignal).toCommand(OpenShopViewCMD);
        signalCommandMap.map(ShopItemSelectedSignal).toCommand(BuyItemCMD);
        signalCommandMap.map(OpenItemPopupSignal).toCommand(OpenItemPopupCMD);
        signalCommandMap.map(UnBuildSignal).toCommand(UnBuildCMD);


        //Models
        injector.map(GameDataModel).asSingleton();

        var assetModel:AssetModel = new AssetModel();
        injector.injectInto(assetModel);
        injector.map(IAssetProvider).toValue(assetModel);
        injector.map(AssetModel).toValue(assetModel);

        mediatorMap.map(UIView).toMediator(UIMediator);
        mediatorMap.map(ShopView).toMediator(ShopMediator);
        mediatorMap.map(ItemPopupView).toMediator(ItemPopupMediator);
    }
}
}
