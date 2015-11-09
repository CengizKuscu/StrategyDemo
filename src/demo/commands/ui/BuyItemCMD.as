/**
 * Created by Cengiz on 6.11.2015.
 */
package demo.commands.ui
{
import demo.game.Game;
import demo.models.vo.BuildingTypeVO;

import robotlegs.bender.bundles.mvcs.Command;

public class BuyItemCMD extends Command
{
    [Inject]
    public var game:Game;

    [Inject]
    public var typeVO:BuildingTypeVO;

    override public function execute():void
    {
        game.placeNewItem(typeVO);
    }
}
}
