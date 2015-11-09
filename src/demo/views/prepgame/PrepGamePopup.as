/**
 * Created by Cengiz on 9.11.2015.
 */
package demo.views.prepgame
{
import demo.models.AssetModel;

import feathers.controls.Button;
import feathers.core.PopUpManager;

import flash.filesystem.File;

import org.osflash.signals.Signal;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;

public class PrepGamePopup extends Sprite
{
    private var mAssetProvider:AssetModel;
    private var mContinueGameBtn:Button;
    private var mNewGameBtn:Button;

    public var startNewGameSignal:Signal;
    public var continueGameSignal:Signal;

    public function PrepGamePopup(assetProvider:AssetModel)
    {
        mAssetProvider = assetProvider;

        var bg:Quad = new Quad(150, 150, 0xfea212);
        addChild(bg);

        var pathToFile:String = File.applicationDirectory.resolvePath('savedata.dat').nativePath;
        var file:File = new File(pathToFile);

        mContinueGameBtn = new Button();
        mContinueGameBtn.label = "CONTINUE";
        mContinueGameBtn.y = 40;
        addChild(mContinueGameBtn);
        mContinueGameBtn.x = 40
        mContinueGameBtn.addEventListener(Event.TRIGGERED, continueGameTrigger);

        mNewGameBtn = new Button();
        mNewGameBtn.label = "NEW GAME";
        mNewGameBtn.y = 80;
        addChild(mNewGameBtn);
        mNewGameBtn.x = 40;
        mNewGameBtn.addEventListener(Event.TRIGGERED, newGameTrigger);

        if (file.exists == false) {
            mContinueGameBtn.isEnabled = false;
            mContinueGameBtn.alpha = 0.7;
        }

        startNewGameSignal = new Signal();
        continueGameSignal = new Signal();
    }

    private function newGameTrigger(e:Event):void
    {
        startNewGameSignal.dispatch();
        PopUpManager.removePopUp(this, true);
    }

    private function continueGameTrigger(e:Event):void
    {
        continueGameSignal.dispatch();
        PopUpManager.removePopUp(this, true);
    }


}
}
