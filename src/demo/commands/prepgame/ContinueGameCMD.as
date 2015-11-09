/**
 * Created by Cengiz on 9.11.2015.
 */
package demo.commands.prepgame
{
import demo.game.Game;

import robotlegs.bender.bundles.mvcs.Command;

public class ContinueGameCMD extends Command
{
    [Inject]
    public var game:Game;

    override public function execute():void
    {
        game.loadItems();
        game.start();
    }
}
}
