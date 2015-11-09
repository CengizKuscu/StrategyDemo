/**
 * Created by Cengiz on 5.11.2015.
 */
package demo.models
{
import starling.textures.Texture;

public interface IAssetProvider
{
    function getTexture(textureName:String):Texture;
}
}
