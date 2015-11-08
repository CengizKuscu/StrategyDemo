/**
 * Created by Cengiz on 8.11.2015.
 */
package demo.views.itempopup
{
import starling.display.Button;
import starling.textures.Texture;

public class PopupCloseBtn extends Button
{
    public function PopupCloseBtn(upState:Texture, text:String = "", downState:Texture = null, overState:Texture = null, disabledState:Texture = null)
    {
        super(upState, text, downState, overState, disabledState);
    }
}
}
