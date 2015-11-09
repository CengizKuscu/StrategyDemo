/**
 * Created by Cengiz on 9.11.2015.
 */
package utils
{
import flash.utils.Dictionary;

public class DictionaryUtils
{
    public static function removeDictionary(dic:Dictionary):void {

        for(var key:Object in dic) {
            if( dic[key]  is Dictionary) {
                removeDictionary(dic[key]);
            }
            else {
                dic[key] = null;
                delete dic[key]
            }
        }
    }

    public static function removeItem(dic:Dictionary, key:Object):void
    {
        if(dic[key] is Dictionary)
        {
            removeDictionary(dic[key])
        }
        else
        {
            dic[key] = null;
            delete  dic[key];
        }
    }
}
}
