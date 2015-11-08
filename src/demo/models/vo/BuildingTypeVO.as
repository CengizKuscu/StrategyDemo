/**
 * Created by Cengiz on 6.11.2015.
 */
package demo.models.vo
{
public class BuildingTypeVO
{
    public var typeId:String;
    public var name:String;
    public var cost:Number;
    public var description:String;
    public var category:String;
    public var pivotX:Number;
    public var pivotY:Number;
    public var scale:Number;

    public function BuildingTypeVO(_typeId:String, _name:String, _cost:Number, _category:String, _scale:Number, _description:String, _pivotX:Number, _pivotY:Number)
    {
        typeId = _typeId;
        name = _name;
        cost = _cost;
        category = _category;
        pivotX = _pivotX;
        pivotY = _pivotY;
        scale = _scale
        description = _description
    }
}
}
