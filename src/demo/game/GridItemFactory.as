/**
 * Created by Cengiz on 7.11.2015.
 */
package demo.game
{
import demo.models.IAssetProvider;
import demo.models.vo.BuildingTypeVO;

import flash.utils.Dictionary;

import starling.display.Image;

import robotlegs.bender.framework.impl.UID;


public class GridItemFactory
{
    private var mAssetProvider:IAssetProvider;
    private var mItemTypeDataById:Dictionary;
    private var mImageCacheByTypeId:Dictionary;

    public function GridItemFactory(assetProvider:IAssetProvider, itemTypeData:Dictionary)
    {
        mAssetProvider = assetProvider;
        mItemTypeDataById = itemTypeData;
        mImageCacheByTypeId = new Dictionary();
    }

    public function createItemImage(itemTypeId:String):Image
    {
        var image:Image = new Image(mAssetProvider.getTexture(itemTypeId));
        var buildingTypeData:BuildingTypeVO = mItemTypeDataById[itemTypeId];

        image.pivotX = image.width*0.5;
        image.pivotY = image.height;
        //TODO change pivot

        if(buildingTypeData != null)
        {
            image.scaleX = image.scaleY = buildingTypeData.scale;
        }

        return image;
    }

    public function createGridItem(itemTypeId:String, X:int, Y:int, id:String = null):GridItem
    {
        var item:GridItem = new GridItem(id || getUniqueId(), itemTypeId, X, Y, getCachedImage(itemTypeId))

        return item;
    }

    public function createFakeGridItem(X:int, Y:int, itemTypeId:String, mergeItem:GridItem):GridItem
    {
        var item:GridItem = new GridItem(null, null, X, Y, null);
        item.tmpMergeId = itemTypeId;
        item.mergeItem = mergeItem;

        return item;
    }

    private function getCachedImage(itemTypeId:String):Image {
        var image:Image = mImageCacheByTypeId[itemTypeId];
        if (image == null) {
            image = createItemImage(itemTypeId);
        }
        return image;
    }

    private static function getUniqueId():String {
        //var _uid:String
        return (Math.floor(Math.random() * 100000000)).toString(16);
    };
}
}
