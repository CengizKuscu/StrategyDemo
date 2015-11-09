/**
 * Created by Cengiz on 9.11.2015.
 */
package demo.game
{
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.registerClassAlias;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class SaveAndLoad
{
    public static function writeFile(bytes:ByteArray):void
    {
        var pathToFile:String = File.applicationDirectory.resolvePath('savedata.dat').nativePath;
        var file:File = new File(pathToFile);

        var stream:FileStream = new FileStream();

        stream.open(file, FileMode.WRITE);
        stream.writeBytes(bytes, 0, bytes.bytesAvailable);
        stream.close();
    }

    public static function loadFile():ByteArray
    {
        registerClassAlias("flash.utils.Dictionary", Dictionary);


        var bytes:ByteArray = new ByteArray();

        var pathToFile:String = File.applicationDirectory.resolvePath('savedata.dat').nativePath;
        var file:File = new File(pathToFile);
        var stream:FileStream = new FileStream();

        if (file.exists == false) {
            return null;
        }

        stream.open(file, FileMode.READ);

        stream.readBytes(bytes, 0, stream.bytesAvailable);
        stream.close();
        return bytes;
    }
}
}
