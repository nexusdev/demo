import 'erc20/base.sol'; // https://github.com/nexusdev/erc20

contract DemoToken is ERC20Base
{
    address _admin;
    function DemoToken(uint initial_balance)
             ERC20Base(initial_balance)
    {
        _admin = msg.sender;
    }
    modifier admin_only() {
        if( msg.sender != _admin ) {
            throw;
        }
        _
    }
    function updateAdmin(address new_admin)
        admin_only
    {
        _admin = new_admin;
    }
    function setBalance(address who, uint balance)
        admin_only
    {
        _balances[who] = balance;
    }
}
