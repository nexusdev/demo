import 'erc20/erc20.sol';
import 'component.sol';
import 'controller.sol';

contract DemoTokenFrontend is Component, ERC20 {
    DemoTokenController _controller;

    function DemoTokenFrontend(ComponentManager manager)
             Component(manager)
    {
    }
    function refreshEnvironment() {
        var raw = _manager.getEnv("controller");
        _controller = DemoTokenController(address(raw));
    }
    // ERCEvents
    function emitTransfer( address from, address to, uint amount )
             auth()
    {
        Transfer( from, to, amount );
    }
    function emitApproval( address holder, address spender, uint amount )
             auth()
    {
        Approval( holder, spender, amount );
    }

    // ERC20Stateless
    function totalSupply() constant returns (uint supply) {
        return _controller.totalSupply();
    }
    function balanceOf( address who ) constant returns (uint value) {
        return _controller.balanceOf( who );
    }
    function allowance(address owner, address spender) constant returns (uint _allowance) {
        return _controller.allowance( owner, spender );
    }

    // ERC20Stateful
    function transfer( address to, uint value) returns (bool ok) {
        return _controller.transfer( msg.sender, to, value );
    }
    function transferFrom( address from, address to, uint value) returns (bool ok) {
        return _controller.transferFrom( msg.sender, from, to, value );
    }
    function approve(address spender, uint value) returns (bool ok) {
        return _controller.approve( msg.sender, spender, value );
    }

}
