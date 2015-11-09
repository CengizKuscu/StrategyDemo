/**
 * Created by Cengiz on 6.11.2015.
 */
package demo.views.shop
{
import com.greensock.TweenLite;

import demo.models.IAssetProvider;
import demo.models.vo.BuildingTypeVO;

import feathers.controls.Button;
import feathers.controls.ScrollContainer;
import feathers.controls.Scroller;
import feathers.controls.TabBar;
import feathers.core.PopUpManager;
import feathers.data.ListCollection;
import feathers.layout.TiledRowsLayout;

import flash.utils.Dictionary;

import org.osflash.signals.Signal;

import starling.display.Button;
import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;

public class ShopView extends Sprite
{
    private var mItemsByCategory:Dictionary;
    private var mAssetProvider:IAssetProvider;
    private var mScrollContainer:ScrollContainer;
    private var mCloseBtn:starling.display.Button;

    public var itemSelected:Signal = new Signal(BuildingTypeVO);

    public function ShopView(itemTypesDic:Dictionary, assetProvider:IAssetProvider)
    {
        mAssetProvider = assetProvider;

        mItemsByCategory = new Dictionary();

        for each (var buildingType:BuildingTypeVO in itemTypesDic) {
            if (mItemsByCategory[buildingType.category] == null) {
                mItemsByCategory[buildingType.category] = new Vector.<BuildingTypeVO>;
            }
            mItemsByCategory[buildingType.category].push(buildingType)
        }

        var bg:Quad = new Quad(450, 440, 0xfea212);
        addChild(bg);

        var tabBar:TabBar = new TabBar();
        tabBar.dataProvider = new ListCollection();

        for (var key:String in mItemsByCategory) {
            tabBar.dataProvider.addItem({label: key, data: mItemsByCategory[key]});
        }

        tabBar.addEventListener(Event.CHANGE, onSelectedTabChanged);
        addChild(tabBar);

        mScrollContainer = new ScrollContainer();
        mScrollContainer.width = 400;
        mScrollContainer.height = 400;
        mScrollContainer.x = 5;
        mScrollContainer.y = 25;
        mScrollContainer.snapToPages = true;
        mScrollContainer.interactionMode = Scroller.INTERACTION_MODE_MOUSE;
        addChild(mScrollContainer);

        var containerLayout:TiledRowsLayout = new TiledRowsLayout();
        containerLayout.gap = 5;
        containerLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
        containerLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_MIDDLE;
        containerLayout.paging = TiledRowsLayout.PAGING_VERTICAL;

        mScrollContainer.layout = containerLayout;

        mCloseBtn = new starling.display.Button(mAssetProvider.getTexture("close"));

        // mCloseBtn.defaultIcon = new Image(mAssetProvider.getTexture("close.png"));
        mCloseBtn.addEventListener(Event.TRIGGERED, onCloseBtnTriggered);
        mCloseBtn.x = 400;
        mCloseBtn.y = 0;
        addChild(mCloseBtn);

        tabBar.selectedIndex = 0;

        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)

    }

    private function onAddedToStage(e:Event):void
    {
        pivotX = this.width * 0.5;
        pivotY = this.height * 0.5;
        this.x = stage.stageWidth * 0.5;
        this.y = stage.stageHeight * 0.5;

        TweenLite.from(this, 0.5, {scaleX: 0, scaleY: 0});
    }

    private function onCloseBtnTriggered(e:Event):void
    {
        PopUpManager.removePopUp(this, true);
    }

    private function onSelectedTabChanged(e:Event):void
    {
        mScrollContainer.removeChildren(0, mScrollContainer.numChildren - 1, true);

        var tabBar:TabBar = e.currentTarget as TabBar;

        var items:Vector.<BuildingTypeVO> = tabBar.selectedItem.data;


        var button:CustomButton;
        var image:Image;
        for each (var itemType:BuildingTypeVO in items) {
            button = new CustomButton();
            image = new Image(mAssetProvider.getTexture(itemType.typeId));
            image.scaleX = image.scaleY = 0.3;
            button.defaultIcon = image;
            button.label = itemType.name + "\n" + "Cost: " + itemType.cost;
            button.iconPosition = feathers.controls.Button.ICON_POSITION_TOP;
            button.name = itemType.typeId;
            button.width = 70;
            button.height = 85;
            button.flatten();
            button.typeVo = itemType;
            button.addEventListener(Event.TRIGGERED, onItemSelected);
            mScrollContainer.addChild(button);
        }
    }

    private function onItemSelected(e:Event):void
    {
        itemSelected.dispatch(e.target["typeVo"]);
        PopUpManager.removePopUp(this, true);
    }

    override public function dispose():void
    {
        TweenLite.killTweensOf(this);
        itemSelected.removeAll();
        mItemsByCategory = null;
        mAssetProvider = null;
        mCloseBtn = null;
        mScrollContainer = null;

        super.dispose();
    }
}
}
