/**
 * Created by Cengiz on 8.11.2015.
 */
package demo.views.itempopup
{
import com.greensock.TweenLite;

import demo.game.GridItem;
import demo.models.AssetModel;
import demo.models.vo.BuildingTypeVO;

import feathers.controls.Button;
import feathers.core.PopUpManager;

import org.osflash.signals.Signal;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class ItemPopupView extends Sprite
{
    private var mAssetProvider:AssetModel;
    private var mBuildTypeVO:BuildingTypeVO;

    private var mCloseBtn:PopupCloseBtn;
    private var mUnBuildBtn:Button;

    public var unBuildSignal:Signal;

    private var mGridItem:GridItem;

    public function ItemPopupView(assetProvider:AssetModel, buildTypeVO:BuildingTypeVO, gridItem:GridItem)
    {
        mAssetProvider = assetProvider;
        mBuildTypeVO = buildTypeVO;
        mGridItem = gridItem;

        var bg:Quad = new Quad(450, 200, 0xfea212);
        addChild(bg);

        var image:Image = new Image(mAssetProvider.getTexture(buildTypeVO.typeId));
        var imgScale:Number = 100 / image.width;
        image.scaleX = image.scaleY = imgScale;
        image.x = 20;
        image.y = 50;
        addChild(image);

        var textField:TextField = new TextField(290, 100, "");
        textField.text = buildTypeVO.description;
        textField.x = 140;
        textField.y = 50;
        textField.border = true;
        textField.hAlign = HAlign.LEFT;
        textField.vAlign = VAlign.TOP;
        //textField.alignPivot(HAlign.LEFT, VAlign.TOP);
        addChild(textField);

        this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

        mCloseBtn = new PopupCloseBtn(assetProvider.getTexture("close"));
        mCloseBtn.addEventListener(Event.TRIGGERED, onCloseBtnTriggered);
        mCloseBtn.x = 400;
        mCloseBtn.y = 0;
        addChild(mCloseBtn);

        mUnBuildBtn = new Button();
        mUnBuildBtn.label = "UNBUILD";
        mUnBuildBtn.x = (bg.width - mUnBuildBtn.width) * 0.5;
        mUnBuildBtn.y = 170;
        addChild(mUnBuildBtn);
        mUnBuildBtn.addEventListener(Event.TRIGGERED, unBuildTrigger);

        unBuildSignal = new Signal();
    }

    private function unBuildTrigger(e:Event):void
    {
        unBuildSignal.dispatch(mGridItem);
        PopUpManager.removePopUp(this, true);
    }

    private function onCloseBtnTriggered(e:Event):void
    {
        PopUpManager.removePopUp(this, true);
    }

    private function onAddedToStage(e:Event):void
    {
        pivotX = this.width * 0.5;
        pivotY = this.height * 0.5;
        this.x = stage.stageWidth * 0.5;
        this.y = stage.stageHeight * 0.5;

        TweenLite.from(this, 0.5, {scaleX: 0, scaleY: 0});
    }
}
}
