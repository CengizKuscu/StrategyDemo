/**
 * Created by Cengiz on 5.11.2015.
 */
package demo.game
{
import flash.geom.Matrix;
import flash.geom.Point;
import flash.utils.Dictionary;

import starling.display.Quad;

import starling.display.QuadBatch;

public class Grid
{
    private var mItems:Vector.<Vector.<GridItem>>;
    private var mGridSize:Number;
    private var mTransform:Matrix;
    private var mInverseTransform:Matrix;
    private var mItemsByItemId:Dictionary;

    public function Grid(cols:int, rows:int, gridSize:Number, offsetX:Number, offsetY:Number)
    {
        mItems = new Vector.<Vector.<GridItem>>(rows);
        for (var i:int = 0; i < rows; i++) {
            mItems[i] = new Vector.<GridItem>(cols);
        }
        mGridSize = gridSize;

        mTransform = new Matrix(1, 0.5, -1, 0.5, 0, 0);
        mTransform.translate(offsetX, offsetY);

        mInverseTransform = mTransform.clone();
        mInverseTransform.invert();

        mItemsByItemId = new Dictionary();


    }

    public function drawGridTo(_qb:QuadBatch):void
    {
        _qb.reset();
        var _quad:Quad;
        var i:int;

        for (i = 0; i <= rowCount; i++) {
            _quad = new Quad(gridSize * colCount, 1, 0xff0000);
            _quad.y = i * gridSize;
            _qb.addQuad(_quad);

        }

        for (i = 0; i <= colCount; i++) {
            _quad = new Quad(1, gridSize * rowCount, 0x000000);
            _quad.x = i * gridSize;
            _qb.addQuad(_quad);
        }

        _qb.transformationMatrix = transform.clone();
    }

    public function getItemIdAt(_x:int, _y:int):GridItem
    {
        if (_x < 0 || _y < 0 || _x >= colCount || _y >= rowCount) {
            return null;
        }
        return mItems[_x][_y];
    }

    public function addItem(_item:GridItem):void
    {
        mItems[_item.gridX][_item.gridY] = _item;
        if (_item != null) {
            mItems[_item.gridX][_item.gridY] = _item;
            mItemsByItemId[_item.id] = _item;
        }
    }

    public function removeItem(_item:GridItem):void
    {
        mItems[_item.gridX][_item.gridY] = null;
    }

    public function removeItemByGridPositions(gridX:int, gridY:int):void
    {
        mItems[gridX][gridY] = null;
    }

    public function getItemByItemId(_itemId:String):GridItem
    {
        return mItemsByItemId[_itemId];
    }

    public function get data():Vector.<Vector.<GridItem>>
    {
        return mItems;
    }

    public function get colCount():int
    {
        return mItems.length;
    }

    public function get rowCount():int
    {
        return mItems[0].length;
    }

    public function get gridSize():Number
    {
        return mGridSize;
    }

    public function get transform():Matrix
    {
        return mTransform;
    }

    public function get inverseTransform():Matrix
    {
        return mInverseTransform;
    }

    public function isAvailable(_pos:Point):Boolean {
        // if out of bounds return false
        if (_pos.x < 0 || _pos.y < 0 || _pos.x >= colCount || _pos.y >= rowCount) {
            return false;
        }
        // if tile is empty at that location, return true

        var gridItem:GridItem = mItems[int(_pos.x)][int(_pos.y)];

        if(gridItem != null)
        {
            if((gridItem.typeId != null && gridItem.id != null) || gridItem.tmpMergeId != null )
            {
                return false;
            }

        }

        return true;


        //return (mItems[int(_pos.x)][int(_pos.y)] == null);
    }

    public function isoToCart(_point:Point):Point {
        var _newPoint:Point = _point.clone();
        _newPoint.x = (_newPoint.x + 1) * mGridSize;
        _newPoint.y = (_newPoint.y + 1) * mGridSize;
        _newPoint = transform.transformPoint(_newPoint);
        return _newPoint;
    }

    public function cartToIso(_point:Point):Point {
        var _newPoint:Point = _point.clone();
        _newPoint = inverseTransform.transformPoint(_newPoint);
        _newPoint.x = Math.floor(_newPoint.x / mGridSize);
        _newPoint.y = Math.floor(_newPoint.y / mGridSize);
        return _newPoint;
    }
}
}
