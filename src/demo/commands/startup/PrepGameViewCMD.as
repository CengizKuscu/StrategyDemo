/**
 * Created by Cengiz on 5.11.2015.
 */
package demo.commands.startup
{
import demo.game.Game;
import demo.game.Grid;
import demo.game.GridItemFactory;
import demo.models.GameDataModel;
import demo.models.IAssetProvider;
import demo.signals.game.OpenItemPopupSignal;
import demo.signals.game.SaveDataSignal;
import demo.views.StarlingRoot;
import demo.views.gameui.UIView;

import flash.geom.Rectangle;

import robotlegs.bender.bundles.mvcs.Command;
import robotlegs.bender.framework.api.IInjector;

import starling.core.Starling;

public class PrepGameViewCMD extends Command
{


    [Inject]
    public var starling:Starling;

    [Inject]
    public var assetProvider:IAssetProvider;

    [Inject]
    public var gameData:GameDataModel;

    [Inject]
    public var injector:IInjector;

    [Inject]
    public var openItemPopupSignal:OpenItemPopupSignal;

    [Inject]
    public var saveDataSignal:SaveDataSignal;

    override public function execute():void
    {
        var grid:Grid = new Grid(
                gameData.gridConfig.colCount,
                gameData.gridConfig.rowCount,
                gameData.gridConfig.gridSize,
                gameData.gridConfig.offsetX,
                gameData.gridConfig.offsetY
        );

        var _bounds:Rectangle = new Rectangle(0, 0, starling.stage.stageWidth, starling.stage.stageHeight - 100);

        var itemFactory:GridItemFactory = new GridItemFactory(assetProvider, gameData.buildingDataByTypeId);

        var game:Game = new Game(assetProvider, grid, _bounds, itemFactory);

        var starlingRoot:StarlingRoot = starling.root as StarlingRoot;
        starlingRoot.addChild(game);

        game.setBG(gameData.bgConfig.name, gameData.bgConfig.width, gameData.bgConfig.height);

        injector.map(Game).toValue(game);

        var uiView:UIView = new UIView(assetProvider);
        starlingRoot.addChild(uiView);


        game.openItemPopupSignal.add(openItemPopupSignal.dispatch);
        game.saveDataSignal.add(saveDataSignal.dispatch);
        game.loadItems();
        game.start();

    }
}
}
