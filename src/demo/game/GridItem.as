/**
 * Created by Cengiz on 5.11.2015.
 */
package demo.game
{
import flash.geom.Point;

import starling.display.Image;

public class GridItem
{

    public var typeId:String;
    public var id:String;
    public var gridX:int;
    public var gridY:int;
    public var image:Image;
    public var tmpMergeId:String;
    public var mergeItem:GridItem;

    public function GridItem(_id:String, _typeId:String, _gridX:int, _gridY:int, _image:Image)
    {
        id = _id;
        typeId = _typeId;
        gridX = _gridX;
        gridY = _gridY;
        image = _image;
    }

    public function dispose():void
    {
        image = null;
    }
}
}
