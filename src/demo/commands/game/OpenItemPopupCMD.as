/**
 * Created by Cengiz on 8.11.2015.
 */
package demo.commands.game
{
import demo.game.GridItem;
import demo.models.GameDataModel;
import demo.models.IAssetProvider;
import demo.models.vo.BuildingTypeVO;
import demo.views.itempopup.ItemPopupView;

import feathers.core.PopUpManager;

import robotlegs.bender.bundles.mvcs.Command;

public class OpenItemPopupCMD extends Command
{
    [Inject]
    public var assetProvider:IAssetProvider;

    [Inject]
    public var typeId:String;

    [Inject]
    public var gameData:GameDataModel;

    [Inject]
    public var gridItem:GridItem;

    override public function execute():void
    {
        var buildData:BuildingTypeVO = gameData.buildingDataByTypeId[typeId];

        var itemPopup:ItemPopupView = new ItemPopupView(assetProvider, buildData, gridItem);
        PopUpManager.addPopUp(itemPopup);
    }
}
}
