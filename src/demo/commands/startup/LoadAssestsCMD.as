/**
 * Created by Cengiz on 5.11.2015.
 */
package demo.commands.startup
{
import demo.models.AssetModel;
import demo.models.GameDataModel;

import robotlegs.bender.bundles.mvcs.Command;

public class LoadAssestsCMD extends Command
{
    [Inject]
    public var gameDataModel:GameDataModel;

    [Inject]
    public var assetModel:AssetModel;


    override public function execute():void
    {
        assetModel.loadResources(gameDataModel.assetUrls);
    }
}
}
