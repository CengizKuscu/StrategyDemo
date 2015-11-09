/**
 * Created by Cengiz on 5.11.2015.
 */
package
{
import demo.commands.game.OpenItemPopupCMD;
import demo.commands.game.SaveDataCMD;
import demo.commands.game.UnBuildCMD;
import demo.commands.prepgame.ContinueGameCMD;
import demo.commands.prepgame.StartNewGameCMD;
import demo.commands.startup.LoadAssestsCMD;
import demo.commands.startup.LoadGameDataCMD;
import demo.commands.startup.PrepGameViewCMD;
import demo.commands.ui.BuyItemCMD;
import demo.commands.ui.OpenShopViewCMD;
import demo.commands.ui.ZoomInCMD;
import demo.commands.ui.ZoomOutCMD;
import demo.models.AssetModel;
import demo.models.GameDataModel;
import demo.signals.game.OpenItemPopupSignal;
import demo.signals.game.SaveDataSignal;
import demo.signals.game.UnBuildSignal;
import demo.signals.prepgame.ContinueGameSignal;
import demo.signals.prepgame.StartNewGameSignal;
import demo.signals.startup.LoadAssetsSignal;
import demo.signals.startup.LoadGameDataSignal;
import demo.signals.startup.PrepGameViewSignal;
import demo.signals.ui.OpenShopViewSignal;
import demo.signals.ui.ShopItemSelectedSignal;
import demo.signals.ui.ZoomInSignal;
import demo.signals.ui.ZoomOutSignal;
import demo.views.gameui.UIMediator;
import demo.views.gameui.UIView;
import demo.views.itempopup.ItemPopupMediator;
import demo.views.itempopup.ItemPopupView;
import demo.views.prepgame.PrepGamePopup;
import demo.views.prepgame.PrepGamePopupMediator;
import demo.views.shop.ShopMediator;
import demo.views.shop.ShopView;

import flash.events.IEventDispatcher;

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
        signalCommandMap.map(SaveDataSignal).toCommand(SaveDataCMD);

        signalCommandMap.map(StartNewGameSignal).toCommand(StartNewGameCMD);
        signalCommandMap.map(ContinueGameSignal).toCommand(ContinueGameCMD);

        //Models
        injector.map(GameDataModel).asSingleton();



        injector.map(AssetModel).asSingleton();

        mediatorMap.map(UIView).toMediator(UIMediator);
        mediatorMap.map(ShopView).toMediator(ShopMediator);
        mediatorMap.map(ItemPopupView).toMediator(ItemPopupMediator);
        mediatorMap.map(PrepGamePopup).toMediator(PrepGamePopupMediator);
    }
}
}
