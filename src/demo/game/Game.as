/**
 * Created by Cengiz on 5.11.2015.
 */
package demo.game
{
import com.greensock.TweenLite;

import demo.game.GridItem;

import demo.models.IAssetProvider;
import demo.models.vo.BuildingTypeVO;
import demo.zoom.PanZoomController;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import org.osflash.signals.Signal;

import starling.display.Image;
import starling.display.QuadBatch;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;
import starling.utils.Color;

public class Game extends Sprite
{
    private var mAssetProvider:IAssetProvider;

    private var mBgImage:Image;
    private var mItemFactory:GridItemFactory;

    private var _mGrid:Grid;

    private var mDisplayBounds:Rectangle;
    private var mRenderBounds:Rectangle;

    private var mGridLinesBatch:QuadBatch;
    private var mGridItemsBatch:QuadBatch;

    private var mDisplayContainer:Sprite;

    private var mPanZoomController:PanZoomController;

    private var mTempItemImage:Image;
    private var mTempItemTypeId:String;
    private var mMouseDownPos:Point;
    private var mCurrentItemData:BuildingTypeVO;

    private var mState:String;

    private const OBJECT_PLACEMENT_STATE:String = "object placement state";
    private const NORMAL_STATE:String = "normal state";


    public var openItemPopupSignal:Signal;

    public var saveDataSignal:Signal;

    public function Game(assetProvider:IAssetProvider, grid:Grid, displayBounds:Rectangle, itemFactory:GridItemFactory)
    {
        mAssetProvider = assetProvider;
        _mGrid = grid;
        mDisplayBounds = displayBounds;
        mItemFactory = itemFactory;
        init();
    }

    private function init():void
    {
        mDisplayContainer = new Sprite();
        addChild(mDisplayContainer);

        mGridLinesBatch = new QuadBatch();
        mGridLinesBatch.touchable = false;
        mDisplayContainer.addChild(mGridLinesBatch);
        _mGrid.drawGridTo(mGridLinesBatch);

        mGridItemsBatch = new QuadBatch();
        mGridItemsBatch.touchable = false;
        mDisplayContainer.addChild(mGridItemsBatch);


        mPanZoomController = new PanZoomController(mDisplayContainer, mDisplayBounds);

        mRenderBounds = mDisplayBounds.clone();
        mRenderBounds.width += 200;
        mRenderBounds.height += 200;
        mRenderBounds.x -= 100;
        mRenderBounds.y -= 100;

        mState = NORMAL_STATE;

        openItemPopupSignal = new Signal();

        saveDataSignal = new Signal();
    }

    public function setBG(textureName:String, W:Number, H:Number):void
    {
        var bgTexture:Texture = mAssetProvider.getTexture(textureName);
        mBgImage = new Image(bgTexture);
        mBgImage.width = W;
        mBgImage.height = H;
        mDisplayContainer.addChildAt(mBgImage, 0);
    }

    public function placeNewItem(typeVO:BuildingTypeVO):void
    {
        mCurrentItemData = typeVO;
        var itemType:String = typeVO.typeId
        if (mState == OBJECT_PLACEMENT_STATE) {
            return;
        }

        mState = OBJECT_PLACEMENT_STATE;

        var tmpImage:Image = mItemFactory.createItemImage(itemType);
        //tmpImage.scaleX = tmpImage.scaleY = 0.75;

        mTempItemImage = tmpImage;
        mTempItemTypeId = itemType;
        mDisplayContainer.addChild(mTempItemImage);
    }

    public function zoomOut():void
    {
        mPanZoomController.zoomOut();
    }

    public function zoomIn():void
    {
        mPanZoomController.zoomIn();
    }

    public function start():void
    {
        this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        mDisplayContainer.addEventListener(TouchEvent.TOUCH, onTouchHandler);
        mPanZoomController.enable();
    }

    public function loadItems():void
    {
        var byteArray:ByteArray = SaveAndLoad.loadFile();
        if (byteArray == null) {
            return;
        }
        var obj:Object = byteArray.readObject() as Dictionary

        var tmpItem:GridItem;

        for each (var item:* in obj) {
            if(item == null)
            {
                continue;
            }
            if (item.typeId != null) {
                tmpItem = mItemFactory.createGridItem(item.typeId, item.gridX, item.gridY, item.id);
            }
            else {
                tmpItem = mItemFactory.createFakeGridItem(item.gridX, item.gridY, item.tmpMergeId, item.mergeItemId, item.id);
            }
            mGrid.addItem(tmpItem);
        }
    }


    private function onTouchHandler(e:TouchEvent):void
    {
        var touch:Touch = e.getTouch(mDisplayContainer);
        if (touch) {
            if (touch.phase == TouchPhase.BEGAN) {
                mMouseDownPos = touch.getLocation(this);
            }
            else if (touch.phase == TouchPhase.HOVER) {
                handleMouseHover(touch)
            }
            else if (touch.phase == TouchPhase.ENDED) {
                var location:Point = touch.getLocation(this);
                if (location.subtract(mMouseDownPos).length < 5) {
                    handleMouseClick(touch);
                }
            }
        }
    }

    private function handleMouseClick(touch:Touch):void
    {
        var clickLocation:Point = touch.getLocation(mDisplayContainer);
        var tilePos:Point = _mGrid.cartToIso(clickLocation);
        if (mState == NORMAL_STATE) {
            var item:GridItem = _mGrid.getItemIdAt(tilePos.x, tilePos.y);
            if (item != null) {
                //TODO Open popup
                if (item.typeId == null) {
                    var tmpItem:GridItem = mGrid.getItemByItemId(item.mergeItemId);
                    openItemPopupSignal.dispatch(tmpItem.typeId, tmpItem)
                }
                else {
                    openItemPopupSignal.dispatch(item.typeId, item);
                }
            }
        }
        else if (mState == OBJECT_PLACEMENT_STATE) {
            if (mCurrentItemData.scale <= 1) {
                if (!_mGrid.isAvailable(tilePos)) {
                    //TODO: Can not build here
                }
                else {
                    var item:GridItem = mItemFactory.createGridItem(mTempItemTypeId, tilePos.x, tilePos.y)
                    _mGrid.addItem(item);
                    cancelObjectPlacement();
                    saveDataSignal.dispatch(mGrid.mItemsByItemId);
                }
            }
            else {
                var tmpPoint0:Point = new Point(tilePos.x - 1, tilePos.y);
                var tmpPoint1:Point = new Point(tilePos.x - 1, tilePos.y - 1);
                var tmpPoint2:Point = new Point(tilePos.x, tilePos.y - 1);

                if (!_mGrid.isAvailable(tilePos) || !_mGrid.isAvailable(tmpPoint0) || !_mGrid.isAvailable(tmpPoint1) || !_mGrid.isAvailable(tmpPoint2)) {
                    //TODO: Can not build here
                }
                else {
                    var item:GridItem = mItemFactory.createGridItem(mTempItemTypeId, tilePos.x, tilePos.y)
                    _mGrid.addItem(item);

                    var tmpItem = mItemFactory.createFakeGridItem(tmpPoint0.x, tmpPoint0.y, mTempItemTypeId, item.id);
                    _mGrid.addItem(tmpItem);
                    tmpItem = mItemFactory.createFakeGridItem(tmpPoint1.x, tmpPoint1.y, mTempItemTypeId, item.id);
                    _mGrid.addItem(tmpItem);
                    tmpItem = mItemFactory.createFakeGridItem(tmpPoint2.x, tmpPoint2.y, mTempItemTypeId, item.id);
                    _mGrid.addItem(tmpItem);

                    cancelObjectPlacement();
                    saveDataSignal.dispatch(mGrid.mItemsByItemId);
                }
            }


        }
    }

    public function cancelObjectPlacement():void
    {
        if (mState != OBJECT_PLACEMENT_STATE) {
            return;
        }
        // dispose temp image
        mTempItemImage.removeFromParent(true);
        mTempItemImage = null;
        mTempItemTypeId = null;
        mState = NORMAL_STATE;
    }

    private function handleMouseHover(touch:Touch):void
    {
        var mousePOS:Point;

        if (mState == OBJECT_PLACEMENT_STATE) {
            mousePOS = touch.getLocation(mDisplayContainer);
            var tilePOS:Point = _mGrid.cartToIso(mousePOS);
            var gridPOS:Point = _mGrid.isoToCart(tilePOS);
            mTempItemImage.x = gridPOS.x;
            mTempItemImage.y = gridPOS.y;
            if (mCurrentItemData.scale <= 1) {
                if (!_mGrid.isAvailable(tilePOS)) {
                    mTempItemImage.color = Color.RED;
                }
                else {
                    mTempItemImage.color = Color.WHITE;
                }
            }
            else {

                var tmpPoint0:Point = new Point(tilePOS.x - 1, tilePOS.y);
                var tmpPoint1:Point = new Point(tilePOS.x - 1, tilePOS.y - 1);

                var tmpPoint2:Point = new Point(tilePOS.x, tilePOS.y - 1);


                if (!_mGrid.isAvailable(tilePOS) || !_mGrid.isAvailable(tmpPoint0) || !_mGrid.isAvailable(tmpPoint1) || !_mGrid.isAvailable(tmpPoint2)) {
                    mTempItemImage.color = Color.RED;
                }
                else {
                    mTempItemImage.color = Color.WHITE;
                }

            }
        }


        mousePOS = touch.getLocation(this);

        if (mousePOS.x < 50) {
            if (mDisplayContainer.x < 0) {
                TweenLite.to(mDisplayContainer, 1, {x: 0});
            }
        }
        else if (mousePOS.x > 935) {
            if (mDisplayContainer.x >= 0) {
                TweenLite.to(mDisplayContainer, 1, {x: 950 - mDisplayContainer.width});
            }
        }

        if (mousePOS.y < 35) {
            if (mDisplayContainer.y < 0) {
                TweenLite.to(mDisplayContainer, 1, {y: 0});
            }
        }
        else if (mousePOS.y > 670) {
            if (mDisplayContainer.y >= 0) {
                TweenLite.to(mDisplayContainer, 1, {y: 700 - mDisplayContainer.height});
            }
        }
    }

    private function onEnterFrame(e:Event):void
    {
        renerGridItems();
    }

    private function renerGridItems():void
    {
        mGridItemsBatch.reset();
        var _globalPos:Point = new Point();
        var _isoPoint:Point = new Point();
        for (var i:int = 0; i < _mGrid.colCount; i++) {
            for (var j:int = 0; j < _mGrid.rowCount; j++) {
                var _item:GridItem = _mGrid.getItemIdAt(i, j);
                if (_item != null) {
                    _isoPoint.setTo(i, j);
                    var _image:Image = _item.image;
                    var _position:Point = _mGrid.isoToCart(_isoPoint);

                    if (_image == null) {
                        continue;
                    }
                    // get target coordinates in global coordinated
                    mGridItemsBatch.localToGlobal(_position, _globalPos);
                    // check if item is in render rectangle
                    if (mRenderBounds.containsPoint(_globalPos)) {
                        _image.x = _position.x;
                        _image.y = _position.y;
                        mGridItemsBatch.addImage(_image);
                    }
                }
            }
        }
    }

    public function get mGrid():Grid
    {
        return _mGrid;
    }

    public function saveGames():void
    {
        saveDataSignal.dispatch(mGrid.mItemsByItemId);
    }
}
}
