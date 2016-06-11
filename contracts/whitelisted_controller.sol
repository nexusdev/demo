import 'controller.sol';
import 'whitelist.sol';

contract WhitelistedController is DemoTokenController {
    Whitelist _whitelist;
    function WhitelistedController( ComponentManager manager)
             DemoTokenController( manager )
    {
    }
    function refreshEnvrironment() {
        super.refreshEnvironment();
        _whitelist = Whitelist(address(_manager.getEnv("whitelist")));
    }
    function transfer(address _caller, address to, uint value) returns (bool)
    {
        if(!_whitelist.allowed(to)) {
            throw;
        }
        return super.transfer(_caller, to, value);
    }
    function transferFrom(address _caller, address from, address to, uint value) returns (bool)
    {
        if(!_whitelist.allowed(to)) {
            throw;
        }
        return super.transferFrom(_caller, from, to, value);
    }

}

