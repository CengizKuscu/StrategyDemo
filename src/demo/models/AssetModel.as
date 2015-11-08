/**
 * Created by Cengiz on 5.11.2015.
 */
package demo.models
{
import demo.signals.PrepGameViewSignal;

import feathers.themes.CastleBuilderTheme;

import starling.textures.Texture;
import starling.utils.AssetManager;

public class AssetModel implements IAssetProvider
{
    private var mAssetManager:AssetManager;

    [Inject]
    public var prepGameViewSignal:PrepGameViewSignal;

    public function AssetModel()
    {
        init();
    }

    private function init():void
    {
        mAssetManager = new AssetManager();
    }

    public function loadResources(urls:Array):void
    {
        for each (var url:String in urls) {
            mAssetManager.enqueue(url)
        }

        mAssetManager.loadQueue(onProgress);
    }

    private function onProgress(ratio:Number):void
    {
        if(ratio == 1)
        {
            //TODO: Prepare Game View
            new CastleBuilderTheme(mAssetManager.getTextureAtlas("game"));
            prepGameViewSignal.dispatch();
        }
    }

    public function getTexture(textureName:String):Texture
    {
        var texture:Texture = mAssetManager.getTexture(textureName);

        if(texture == null)
        {
            trace("Texture "+textureName+ " not found. Using debug texture!");
            texture = Texture.fromColor(100, 100, 0xff0000);
        }
        return texture;
    }
}
}
