import 'component.sol';
contract Whitelist is Component {
    mapping(address=>bool) public _allowed;
    function Whitelist(ComponentManager manager)
             Component(manager)
    {}
    function allowed(address who) returns (bool) {
        return _allowed[who];
    }
    function setAllowed(address who, bool what)
        auth
    {
        _allowed[who] = what;
    }
}
