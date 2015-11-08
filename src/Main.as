package {

import demo.signals.LoadGameDataSignal;
import demo.views.StarlingRoot;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.events.Event;

import org.osflash.signals.Signal;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.impl.Context;
import robotlegs.extensions.starlingViewMap.StarlingViewMapExtension;

import starling.core.Starling;
import starling.events.Event;

[SWF(width=950, height=700)]
public class Main extends Sprite
{
    private var mContext:IContext;
    private var mStarling:Starling;

    public function Main()
    {
        addEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStaege);
    }

    private function onAddedToStaege(e:flash.events.Event):void
    {
        stage.align		= StageAlign.TOP_LEFT;
        stage.color		= 0x0;
        stage.scaleMode	= StageScaleMode.NO_SCALE;
        stage.frameRate	= 60;
        // TODO comment
        stage.quality	= StageQuality.LOW;

        mStarling       = new Starling(StarlingRoot, stage);
        mStarling.addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
        mStarling.start();
        mStarling.showStats = true;

    }

    private function onRootCreated(e:starling.events.Event):void
    {
        mContext = new Context().install(MVCSBundle, SignalCommandMapExtension, StarlingViewMapExtension).configure(new ContextView(this), mStarling, DemoBuilderConfig);

        var loadGameDataSignal:Signal = mContext.injector.getInstance(LoadGameDataSignal);
        loadGameDataSignal.dispatch();
    }
}
}
