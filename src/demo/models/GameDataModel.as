/**
 * Created by Cengiz on 5.11.2015.
 */
package demo.models
{
import demo.models.vo.BgConfigVO;
import demo.models.vo.BuildingTypeVO;
import demo.models.vo.GridConfigVO;
import demo.signals.LoadAssetsSignal;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.Dictionary;

public class GameDataModel
{
    public var bgConfig:BgConfigVO;

    public var gridConfig:GridConfigVO;

    public var assetUrls:Array;

    [Inject]
    public var loadAssetSignal:LoadAssetsSignal;

    public var buildingDataByTypeId:Dictionary;

    public function loadGameData(url:String):void
    {
        var urlReq:URLRequest = new URLRequest(url);
        var urlLoader:URLLoader = new URLLoader(urlReq);
        urlLoader.addEventListener(Event.COMPLETE, onGameDataLoaded);
        urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onGameDataLoadError);
        urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onGameDataLoadError);
        urlLoader.load(urlReq);
    }

    private function onGameDataLoaded(e:Event):void
    {
        buildingDataByTypeId = new Dictionary();
        var urlLoader:URLLoader = e.target as URLLoader;
        var xmlData:XML = new XML(urlLoader.data);

        for each (var _building:XML in XMLList(xmlData.Buildings.Building)) {
            var _buildingType:BuildingTypeVO = new BuildingTypeVO(
                    String(_building.@typeId),
                    String(_building.@name),
                    Number(_building.@cost),
                    String(_building.@category),
                    Number(_building.@scale),
                    String(_building.@description),
                    Number(_building.@pivotPointX),
                    Number(_building.@pivotPointY)
            );
            buildingDataByTypeId[_buildingType.typeId] = _buildingType;
        };

        var _gridConfigXML:XML = xmlData.GridConfig[0];
        gridConfig = new GridConfigVO();
        gridConfig.colCount = int(_gridConfigXML.@colCount);
        gridConfig.rowCount = int(_gridConfigXML.@rowCount);
        gridConfig.gridSize = Number(_gridConfigXML.@gridSize);
        gridConfig.offsetX = Number(_gridConfigXML.@offsetX);
        gridConfig.offsetY = Number(_gridConfigXML.@offsetY);

        //read background config
        var bgConfigXML:XML = xmlData.BGConfig[0];
        bgConfig = new BgConfigVO();
        bgConfig.name = String(bgConfigXML.@name);
        bgConfig.width = Number(bgConfigXML.@width);
        bgConfig.height = Number(bgConfigXML.@height);

        //read assets
        assetUrls = [];
        for each (var assetXML:XML in XMLList(xmlData.Assets.Asset)) {
            assetUrls.push(String(assetXML.@url));
        }

        trace("Complete: Game Data loaded");
        loadAssetSignal.dispatch();

    }

    private function onGameDataLoadError(e:SecurityErrorEvent):void
    {
        trace("Error: Loading Game Data");
    }
}
}
