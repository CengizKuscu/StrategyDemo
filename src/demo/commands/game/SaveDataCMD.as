/**
 * Created by Cengiz on 9.11.2015.
 */
package demo.commands.game
{
import demo.game.SaveAndLoad;

import flash.net.registerClassAlias;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import robotlegs.bender.bundles.mvcs.Command;

public class SaveDataCMD extends Command
{
    [Inject]
    public var mData:Dictionary;


    override public function execute():void
    {
        registerClassAlias("flash.utils.Dictionary", Dictionary);

        var bytes:ByteArray = new ByteArray();
        bytes.writeObject(mData);
        SaveAndLoad.writeFile(bytes);
    }
}
}
