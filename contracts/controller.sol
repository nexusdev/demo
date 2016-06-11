import 'component.sol';
import 'token.sol';
import 'datastore.sol';

contract DemoTokenController is Component
{
    // Swappable database contract
    DemoTokenDB                _db;
    // Trust calls from this address and report events here.
    DemoTokenFrontend          _frontend;

    // Setup and admin functions
    function DemoTokenController( ComponentManager manager )
             Component(manager)
    {
    }
    function refreshEnvironment() {
        _frontend = DemoTokenFrontend(address(_manager.getEnv("frontend")));
        _db = DemoTokenDB(address(_manager.getEnv("db")));
    }


    // Stateless ERC20 functions. Doesn't need to know who the sender is.
    function totalSupply() constant returns (uint supply) {
        return _db.getSupply();
    }
    function balanceOf( address who ) constant returns (uint amount) {
        return _db.getBalance( who );
    }
    function allowance(address owner, address spender) constant returns (uint _allowance) {
        return _db.getApproval(owner, spender);
    }


    // Each stateful ERC20 function signature has an parallel function
    // which takes a `msg.sender` as the first argument. Each such "implementation"
    // function needs to report any events back to the "frontend" contract.

    // Only trust calls from the frontend contract.
    function transfer(address _caller, address to, uint value)
             auth()
             returns (bool ok)
    {
        if( _db.getBalance(_caller) < value ) {
            throw;
        }
        if( !safeToAdd(_db.getBalance(to), value) ) {
            throw;
        }
        _db.moveBalance(_caller, to, value);
        _frontend.emitTransfer( _caller, to, value );
        return true;
    }
    function transferFrom(address _caller, address from, address to, uint value)
             auth()
             returns (bool)
    {
        var from_balance = _db.getBalance( from );
        // if you don't have enough balance, throw
        if( _db.getBalance(from) < value ) {
            throw;
        }

        // if you don't have approval, throw
        var allowance = _db.getApproval( from, _caller );
        if( allowance < value ) {
            throw;
        }

        if( !safeToAdd(_db.getBalance(to), value) ) {
            throw;
        }
        _db.setApproval( from, _caller, allowance - value );
        _db.moveBalance( from, to, value);
        _frontend.emitTransfer( from, to, value );
        return true;
    }
    function approve( address _caller, address spender, uint value)
             auth()
             returns (bool)
    {
        _db.setApproval( _caller, spender, value );
        _frontend.emitApproval( _caller, spender, value);
    }
    function safeToAdd(uint a, uint b) internal returns (bool) {
        return (a + b >= a);
    }
    function safeAdd(uint a, uint b) internal returns (uint) {
        if (!safeToAdd(a, b)) throw;
        return a + b;
    }

}
