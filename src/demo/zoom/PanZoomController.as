/**
 * Created by Cengiz on 6.11.2015.
 */
package demo.zoom
{
import com.greensock.TweenLite;

import flash.geom.Point;
import flash.geom.Rectangle;

import starling.display.DisplayObject;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class PanZoomController
{
    private var mTarget:DisplayObject;
    private var mBounds:Rectangle;
    private var mDisplayPanTarget:Point;
    private var mZoom:Number = 1;

    private var mZoomValues:Array = [0.5, 0.75, 1];
    private var mCurrentZoomIndex:int = 1;

    public function PanZoomController(target:DisplayObject, bounds:Rectangle)
    {
        mTarget = target;
        mBounds = bounds;

        mDisplayPanTarget = new Point(mTarget.x, mTarget.y);
        zoom = mZoomValues[mCurrentZoomIndex];
    }

    public function enable():void
    {
        mTarget.addEventListener(TouchEvent.TOUCH, onTouchHandle);
    }

    public function disable():void
    {
        mTarget.removeEventListener(TouchEvent.TOUCH, onTouchHandle);
    }

    private function onTouchHandle(_event:TouchEvent):void
    {
        var _touchList:Vector.<Touch> = _event.getTouches(mTarget);

        if (_touchList.length == 0) return;

        var _touch:Touch = _touchList[0];

        if (_touch.phase == TouchPhase.BEGAN) {

        }
        else if (_touch.phase == TouchPhase.MOVED) {
            pan(_touch.getMovement(mTarget));
        }
        else if (_touch.phase == TouchPhase.ENDED) {
//            var _location = _touch.getLocation(mTarget);
//            trace(_location, mGrid.cartToIso(_location));
//            trace(mGrid, mGrid.isoToCart(mGrid.cartToIso(_location)));
        }
    }

    private function pan(_deltaLocation:Point):void
    {
        mTarget.x += _deltaLocation.x;
        mTarget.y += _deltaLocation.y;

        validatePanPosition();
    }

    public function get zoom():Number
    {
        return mZoom;
    }

    public function set zoom(_value:Number):void
    {

        if (mZoom != _value) {
            var _displayBoundsCenter:Point = new Point(mBounds.x + mBounds.width / 2, mBounds.y + mBounds.height / 2);
            var _zoomCenter:Point = mTarget.globalToLocal(_displayBoundsCenter);
            scaleAround(_zoomCenter.x, _zoomCenter.y, _value, _value);
            validatePanPosition();
        }
        mZoom = _value;
    }

    public function validatePanPosition():void
    {
        if (mTarget.x > mBounds.x) {
            mTarget.x = mBounds.x;
        }

        if ((mTarget.x + mTarget.width) < (mBounds.x + mBounds.width)) {
            mTarget.x = mBounds.x + mBounds.width - mTarget.width;
        }


        if (mTarget.y > mBounds.y) {
            mTarget.y = mBounds.y;
        }

        if ((mTarget.y + mTarget.height) < (mBounds.y + mBounds.height)) {
            mTarget.y = mBounds.y + mBounds.height - mTarget.height;
        }
    }

    /**
     * Scales object around the given offsets.
     * @param offsetX
     * @param offsetY
     * @param absScaleX
     * @param absScaleY
     */
    protected function scaleAround(offsetX:Number, offsetY:Number, absScaleX:Number, absScaleY:Number):void
    {
        var relScaleX:Number = absScaleX / mTarget.scaleX;
        var relScaleY:Number = absScaleY / mTarget.scaleY;
        // center offset relative to parent
        var offset:Point = new Point(offsetX, offsetY);
        offset = mTarget.localToGlobal(offset);
        offset = mTarget.parent.globalToLocal(offset);
        // current position relative to parent
        var curPos:Point = new Point(mTarget.x, mTarget.y);

        // center point translation
        var center:Point = curPos.subtract(offset);
        center.x *= relScaleX;
        center.y *= relScaleY;
        curPos = offset.add(center);

        mTarget.scaleX *= relScaleX;
        mTarget.scaleY *= relScaleY;

        mDisplayPanTarget.x = mTarget.x = curPos.x;
        mDisplayPanTarget.y = mTarget.y = curPos.y;

    }

    public function zoomIn():void
    {
        if (mCurrentZoomIndex + 1 < mZoomValues.length) {
            zoomTo(mZoomValues[++mCurrentZoomIndex]);
        }
    }

    public function zoomOut():void
    {
        if (mCurrentZoomIndex - 1 >= 0) {
            zoomTo(mZoomValues[--mCurrentZoomIndex]);
            trace(mCurrentZoomIndex);
        }
    }

    public function zoomTo(_value:Number):void
    {
        TweenLite.to(this, 0.5, {zoom: _value});
    }
}
}
