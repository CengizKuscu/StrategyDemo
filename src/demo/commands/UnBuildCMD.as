/**
 * Created by Cengiz on 8.11.2015.
 */
package demo.commands
{
import demo.game.Game;
import demo.game.GridItem;
import demo.models.vo.BuildingTypeVO;

import flash.geom.Point;

import robotlegs.bender.bundles.mvcs.Command;

public class UnBuildCMD extends Command
{
    [Inject]
    public var game:Game;

    [Inject]
    public var gridItem:GridItem;

    override public function execute():void
    {
        var tmpPoint0:Point = new Point(gridItem.gridX - 1, gridItem.gridY);
        var tmpPoint1:Point = new Point(gridItem.gridX - 1, gridItem.gridY - 1);

        var tmpPoint2:Point = new Point(gridItem.gridX, gridItem.gridY - 1);
        game.mGrid.removeItem(gridItem);
        game.mGrid.removeItemByGridPositions(tmpPoint0.x, tmpPoint0.y);
        game.mGrid.removeItemByGridPositions(tmpPoint1.x, tmpPoint1.y);
        game.mGrid.removeItemByGridPositions(tmpPoint2.x, tmpPoint2.y);
    }
}
}
