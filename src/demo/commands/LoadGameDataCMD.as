/**
 * Created by Cengiz on 5.11.2015.
 */
package demo.commands
{
import demo.models.GameDataModel;

import robotlegs.bender.bundles.mvcs.Command;

public class LoadGameDataCMD extends Command
{
    [Inject]
    public var gamedataModel:GameDataModel;


    override public function execute():void
    {
        gamedataModel.loadGameData(DemoBuilderConfig.GAME_DATA_URL);
    }
}
}
