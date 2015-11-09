/**
 * Created by Cengiz on 9.11.2015.
 */
package demo.views.prepgame
{
import demo.signals.prepgame.ContinueGameSignal;
import demo.signals.prepgame.StartNewGameSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PrepGamePopupMediator extends Mediator
{
    [Inject]
    public var view:PrepGamePopup;

    [Inject]
    public var startNewGameSignal:StartNewGameSignal;

    [Inject]
    public var continueGameSignal:ContinueGameSignal;

    override public function initialize():void
    {
        view.continueGameSignal.add(continueGameSignal.dispatch);
        view.startNewGameSignal.add(startNewGameSignal.dispatch);
    }

    override public function destroy():void
    {
        view.continueGameSignal.remove(continueGameSignal.dispatch);
        view.startNewGameSignal.remove(startNewGameSignal.dispatch);
    }
}
}
