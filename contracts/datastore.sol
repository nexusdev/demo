import 'component.sol';

contract DemoTokenDB is Component
{
    uint _supply;
    mapping( address => uint )  _balances;
    mapping(address => mapping( address=>uint)) _approvals;

    function DemoTokenDB(ComponentManager manager)
             Component(manager)
    {
    }

    function setApproval( address holder, address spender, uint amount )
             auth()
    {
        _approvals[holder][spender] = amount;
    }
    function getApproval( address holder, address spender )
             returns (uint amount )
    {
        return _approvals[holder][spender];
    }
    function getSupply()
             constant
             returns (uint)
    {
        return _supply;
    }
    function getBalance( address who )
             constant
             returns (uint)
    {
        return _balances[who];
    }
    function setBalance( address who, uint new_balance )
             auth()
    {
        var old_balance = _balances[who];
        if( new_balance <= old_balance ) {
            _supply = safeSub( _supply, old_balance - new_balance );
        } else {
            _supply = safeAdd( _supply, new_balance - old_balance );
        }
        _balances[who] = new_balance;
    }
    function addBalance( address to, uint amount )
             auth()
    {
        _supply = safeAdd( _supply, amount );
        _balances[to] = safeAdd( _balances[to], amount );
    }
    function subBalance( address from, uint amount )
             auth()
    {
        _supply = safeSub( _supply, amount );
        _balances[from] = safeSub( _balances[from], amount );
    }
    function moveBalance( address from, address to, uint amount )
             auth()
    {
        _balances[from] = safeSub( _balances[from], amount );
        _balances[to] = safeAdd( _balances[to], amount );
    }
    function safeToAdd(uint a, uint b) internal returns (bool) {
        return (a + b >= a);
    }
    function safeAdd(uint a, uint b) internal returns (uint) {
        if (!safeToAdd(a, b)) throw;
        return a + b;
    }
    function safeToSubtract(uint a, uint b) internal returns (bool) {
        return (b <= a);
    }
    function safeSub(uint a, uint b) internal returns (uint) {
        if (!safeToSubtract(a, b)) throw;
        return a - b;
    }
}
