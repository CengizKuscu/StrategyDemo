/**
 * Created by Cengiz on 6.11.2015.
 */
package demo.commands.ui
{
import demo.game.Game;

import robotlegs.bender.bundles.mvcs.Command;

public class ZoomOutCMD extends Command
{
    [Inject]
    public var game:Game;

    override public function execute():void
    {
        game.zoomOut();
    }
}
}
