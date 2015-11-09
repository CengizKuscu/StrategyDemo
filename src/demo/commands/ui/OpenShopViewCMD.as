/**
 * Created by Cengiz on 6.11.2015.
 */
package demo.commands.ui
{
import demo.models.GameDataModel;
import demo.models.IAssetProvider;
import demo.views.shop.ShopView;

import feathers.core.PopUpManager;

import robotlegs.bender.bundles.mvcs.Command;

import starling.core.Starling;

public class OpenShopViewCMD extends Command
{
    [Inject]
    public var starling:Starling;

    [Inject]
    public var gameData:GameDataModel;

    [Inject]
    public var assetProvider:IAssetProvider;

    override public function execute():void
    {
        var view:ShopView = new ShopView(gameData.buildingDataByTypeId, assetProvider);
        PopUpManager.addPopUp(view, true, false);
    }
}
}
